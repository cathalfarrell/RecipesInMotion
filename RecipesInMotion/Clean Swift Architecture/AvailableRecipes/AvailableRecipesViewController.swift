//
//  AvailableRecipesViewController.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 02/09/2021.
//  Copyright (c) 2021 @thal Productions All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AvailableRecipesDisplayLogic: AnyObject {
	func returnAvailableIngredients(viewModel: Ingredients.FetchIngredients.ViewModel)
	func returnAllRecipes(viewModel: AvailableRecipes.FetchRecipes.ViewModel)
	func displayAvailableRecipes(viewModel: AvailableRecipes.FetchAvailableRecipes.ViewModel)
}

class AvailableRecipesViewController: UIViewController, AvailableRecipesDisplayLogic {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var headerSubTitle: UILabel!

	var sectionTitle = "Available Recipes"
	var sectionImage = "Recipes-Image"
	var ingredients: [String] = [String]()
	var allRecipes: [Recipe] = [Recipe]()
	var availableRecipes: [Recipe] = [Recipe]()
	let sectionHeaderHeight: CGFloat = 100

	var interactor: AvailableRecipesBusinessLogic?
	var router: (NSObjectProtocol & AvailableRecipesRoutingLogic & AvailableRecipesDataPassing)?

	// MARK: Object lifecycle

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: Setup

	private func setup() {
		let viewController = self
		let interactor = AvailableRecipesInteractor()
		let presenter = AvailableRecipesPresenter()
		let router = AvailableRecipesRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}

	// MARK: Routing

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}

	// MARK: View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTable()
		fetchRecipes()
		fetchAvailableIngredients()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	fileprivate func setupTable() {
		// Register the custom header view.
		let cellNib = UINib(nibName: "IngredientTableViewCell", bundle: nil)
		tableView.register(cellNib, forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .black
	}

	// MARK: Get the data
	func fetchAvailableIngredients() {
		let request = Ingredients.FetchIngredients.Request()
		interactor?.fetchIngredients(request: request)
	}

	func fetchRecipes() {
		let request = AvailableRecipes.FetchRecipes.Request()
		interactor?.fetchRecipes(request: request)
	}

	func fetchAvailableRecipes() {
		guard self.ingredients.count > 0, allRecipes.count > 0 else {
			return
				Log.e("Missing ingredients and recipes")
		}
		let request = AvailableRecipes.FetchAvailableRecipes.Request(allRecipes: self.allRecipes,
																	 ingredients: self.ingredients)
		interactor?.fetchAvailableRecipes(request: request)
	}

	// MARK: Display the results

	func returnAllRecipes(viewModel: AvailableRecipes.FetchRecipes.ViewModel) {
		self.allRecipes = viewModel.recipes
	}

	func returnAvailableIngredients(viewModel: Ingredients.FetchIngredients.ViewModel) {
		self.ingredients = viewModel.ingredients
		updateHeaderText(with: self.ingredients)
		// Now that we have ingredients we can search our recipes for valid recipes
		fetchAvailableRecipes()
	}

	func updateHeaderText(with ingredients: [String]) {
		let myIngredients = ingredients.capitalise().joined(separator: ", ")
		let textToDisplay = "These recipes can be made with your ingredients: \(myIngredients)"
		headerSubTitle.text = textToDisplay
	}

	func displayAvailableRecipes(viewModel: AvailableRecipes.FetchAvailableRecipes.ViewModel) {
		self.availableRecipes = viewModel.recipes
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
extension AvailableRecipesViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 64
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return sectionHeaderHeight
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		// Create a section header view programatically

		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: sectionHeaderHeight))
		let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		label.textColor = .white
		label.text = self.availableRecipes[section].name

		let imageView = ImageWithGradientBottom(frame: CGRect(x: 0, y: 0,
															  width: tableView.frame.size.width,
															  height: sectionHeaderHeight))
		imageView.image = self.availableRecipes[section].getImage()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true

		view.insertSubview(imageView, at: 0)

		view.addSubview(label)
		view.backgroundColor = UIColor.black

		// Need to programatically add the constraints

		imageView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			// Bind image to all sides
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			// Position label with a leading margin and bound to all sides
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor,
				   constant: 20),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			label.topAnchor.constraint(equalTo: view.topAnchor),
			label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		return view
	}
}
extension AvailableRecipesViewController: UITableViewDataSource {

	// MARK: - Table view data source

	func numberOfSections(in tableView: UITableView) -> Int {
		return self.availableRecipes.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return self.availableRecipes[section].ingredients.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.availableRecipes[section].name
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let recipe = self.availableRecipes[indexPath.section]
		let ingredient = recipe.ingredients[indexPath.row]

		guard
			let ingredientTableViewCell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.reuseIdentifier,
																		  for: indexPath) as? IngredientTableViewCell else {
			Log.e("Failed to find ingredientTableViewCell to dequeue")
			return UITableViewCell()
		}
		ingredientTableViewCell.configure(for: ingredient)
		return ingredientTableViewCell
	}

}
