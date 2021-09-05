//
//  AvailableRecipesModels.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 02/09/2021.
//  Copyright (c) 2021 @thal Productions All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
// swiftlint:disable nesting

import UIKit

enum AvailableRecipes {
	enum FetchRecipes {
		struct Request {
		}
		struct Response {
			var recipes: [Recipe]?
			var error: Error?
		}
		struct ViewModel {
			var recipes: [Recipe]
			var errorMessage: String?
		}
	}
	enum FetchAvailableRecipes {
		struct Request {
			var allRecipes: [Recipe]
			var ingredients: [String]
		}
		struct Response {
			var recipes: [Recipe]?
			var error: Error?
		}
		struct ViewModel {
			var recipes: [Recipe]
			var errorMessage: String?
		}
	}

}