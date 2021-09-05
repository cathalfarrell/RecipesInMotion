//
//  Recipe.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 02/09/2021.
//

import UIKit

// MARK: - Recipe Model

struct Recipe: Codable, Equatable {
	var name: String
	var ingredients: [String]
}
extension Recipe {
	func getImage() -> UIImage? {
		switch name.capitalized {
		case "Tomato Pasta":
			return UIImage(named: "tomato-pasta")
		case "Chicken Tikka Masala":
			return UIImage(named: "chicken-tikka-masala")
		case "Cheesecake":
			return UIImage(named: "cheesecake")
		case "Chocolate Brownie":
			return UIImage(named: "chocolate-brownie")
		case "Meatball":
			return UIImage(named: "meatball")
		case "Meatloaf":
			return UIImage(named: "meatloaf")
		default:
			return UIImage(named: "Ingredients-Image")
		}
	}
}

// MARK: - RecipeArray

typealias RecipeArray = [Recipe]

extension RecipeArray {

	//// Capitalises the name and every string in the ingredients array

	func capitalise() -> [Recipe] {
		var capitalisedRecipes = [Recipe]()
		for recipe in self {
			let capitalisedRecipe = Recipe(name: recipe.name.capitalized, ingredients: recipe.ingredients.capitalise())
			capitalisedRecipes.append(capitalisedRecipe)
		}
		return capitalisedRecipes
	}
}
