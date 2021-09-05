//
//  RecipesService.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 31/08/2021.
//  Copyright © 2021 RecipiesInMotion. All rights reserved.
//
// swiftlint:disable vertical_parameter_alignment

import Foundation
import Alamofire

typealias APIResponseRecipes = [Recipe]

struct RecipesService {

	static let shared = RecipesService()

	func getRecipes(_ completion: @escaping (Result<APIResponseRecipes>) -> Void) {

		if let jsonData = readJSONFromFile(fileName: "MyRecipes") {
			let decoder = JSONDecoder()
			do {
				let response = try decoder.decode(APIResponseRecipes.self, from: jsonData)
				Log.v("Successfully parsed result")
				completion(Result.success(response))

			} catch let err {
				Log.e("Unable to parse JSON response: \(err.localizedDescription)")
				completion(Result.failure(err))
			}

		} else {
			Log.e("Failed to local read JSON data")
		}
	}

	func getRecipes(recipes: [Recipe], for ingredients: [String],
					_ completion: @escaping (Result<APIResponseRecipes>) -> Void) {

		var validRecipes = [Recipe]()

		for recipe in recipes {
			if checkRecipeHasAllIngredients(recipe: recipe, availableIngredients: ingredients) {
				validRecipes.append(recipe)
			}
		}

		let response = APIResponseRecipes(validRecipes)
		completion(Result.success(response))

	}

	func checkRecipeHasAllIngredients(recipe: Recipe, availableIngredients: [String]) -> Bool {

		guard !availableIngredients.isEmpty else {
			return false
		}
		for ingredient in recipe.ingredients where !ingredient.isEmpty {
			if  !availableIngredients.contains(ingredient) {
				return false
			}
		}
		return true
	}

	func readJSONFromFile(fileName: String) -> Data? {
		var data: Data?
		if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
			do {
				let fileUrl = URL(fileURLWithPath: path)
				// Getting data from JSON file using the file URL
				data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)

			} catch let error {
				// Handle error here
				Log.e("Whoops error found: \(error)")
			}
		}
		return data
	}
}
