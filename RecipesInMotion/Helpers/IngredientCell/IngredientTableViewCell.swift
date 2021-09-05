//
//  TableViewCell.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 03/09/2021.
//
//  swiftlint:disable cyclomatic_complexity

import UIKit

class IngredientTableViewCell: UITableViewCell, SelfConfiguringCell {
	static var reuseIdentifier = "ingredientTableViewCell"

	@IBOutlet weak var ingredientView: UIView!
	@IBOutlet weak var ingredientName: UILabel!
	@IBOutlet weak var ingredientEmoji: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code

		// Circular image
		self.ingredientView.backgroundColor = .white
		self.ingredientView.layer.cornerRadius = 20.0
		self.ingredientView.layer.borderWidth = 1.0
		self.ingredientView.layer.borderColor = UIColor.white.cgColor
		self.ingredientView.clipsToBounds = true
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
extension IngredientTableViewCell {
	func configure(for ingredient: String) {
		ingredientName.text = ingredient
		ingredientEmoji.text = getEmoji(for: ingredient)
	}

	func getEmoji(for ingredient: String) -> String {

		switch ingredient {
		case "Meat":
			return "🥩"
		case "Egg":
			return "🥚"
		case "Onion":
			return "🧅"
		case "Parmesan":
			return "🧀"
		case "Butter":
			return "🧈"
		case "Sugar":
			return "🍭"
		case "Chicken":
			return "🐓"
		case "Tomato":
			return "🍅"
		case "Pasta":
			return "🍝"
		case "Water":
			return "💧"
		case "Biscuit":
			return "🍪"
		case "Chocolate":
			return "🍫"
		default:
			return "🥘"
		}
	}
}
