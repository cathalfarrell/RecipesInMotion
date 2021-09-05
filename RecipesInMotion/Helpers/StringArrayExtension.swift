//
//  StringArrayExtension.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 02/09/2021.
//

import Foundation
import UIKit

typealias StringArray = [String]

extension StringArray {

	/// Capitalises every string in the array

	func capitalise() -> [String] {
		var capitalisedIngredients = [String]()
		for ingredient in self {
			capitalisedIngredients.append(ingredient.capitalized)
		}
		return capitalisedIngredients
	}
}
