//
//  RecipesInMotionTests.swift
//  RecipesInMotionTests
//
//  Created by Cathal Farrell on 01/09/2021.
//

import XCTest
@testable import RecipesInMotion

class RecipesInMotionTests: XCTestCase {

	var allRecipes = [Recipe]()

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.

		let recipe1 = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
		let recipe2 = Recipe(name: "Chicken tikka masala", ingredients: ["chicken", "butter", "onion"])
		let recipe3 = Recipe(name: "Cheesecake", ingredients: ["biscuit", "butter", "sugar"])
		let recipe4 = Recipe(name: "Chocolate brownie", ingredients: ["chocolate", "butter", "sugar"])
		let recipe5 = Recipe(name: "Meatball", ingredients: ["Meat", "parmesan", "onion"])
		let recipe6 = Recipe(name: "Meatloaf", ingredients: ["Meat", "egg", "onion"])
		allRecipes.append(recipe1)
		allRecipes.append(recipe2)
		allRecipes.append(recipe3)
		allRecipes.append(recipe4)
		allRecipes.append(recipe5)
		allRecipes.append(recipe6)
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		measure {
			// Put the code you want to measure the time of here.
		}
	}

	func testGetIngredients() throws {
		IngredientsService.shared.getAvailableIngredients {(resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count > 0, "Ingredients returned")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipies() throws {
		RecipesService.shared.getRecipes {(resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count > 0, "Recipes returned")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipesWithNoIngredients() throws {
		let recipes = [Recipe]()
		let ingredients = [String]()
		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 0, "Recipes returned")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testRecipeHasAllIngredients() throws {
		let recipe = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
		let check = RecipesService.shared.checkRecipeHasAllIngredients(recipe: recipe,
																	   availableIngredients: ["tomato", "pasta", "water"])
		XCTAssertTrue(check, "Has all ingredients for Tomato Pasta")
	}

	func testRecipeDoesNotHaveAllIngredients() throws {
		let recipe = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
		let check = RecipesService.shared.checkRecipeHasAllIngredients(recipe: recipe,
																	   availableIngredients: ["tomato", "water"])
		XCTAssertFalse(check, "Has missing ingredients for Tomato Pasta")
	}

	func testRecipeWhenIHaveNoIngredients() throws {
		let noIngredients = [String]()
		let recipe = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
		let check = RecipesService.shared.checkRecipeHasAllIngredients(recipe: recipe, availableIngredients: noIngredients)
		XCTAssertFalse(check, "Has no ingredients for Tomato Pasta")
	}

	func testGetRecipesForIngredientsWhenNoRecipes() throws {
		let noRecipes = [Recipe]()
		let ingredients = ["tomato", "pasta", "water"]
		RecipesService.shared.getRecipes(recipes: noRecipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 0, "Recipes returned")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetNoRecipesNoIngredients() throws {
		let noRecipes = [Recipe]()
		let noIngredients = [String]()

		RecipesService.shared.getRecipes(recipes: noRecipes, for: noIngredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 0, "Recipes not zero")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipesForTomatoPasta() throws {
		/*
		{
		"name" : "Tomato pasta",
		"ingredients" : ["tomato", "pasta", "water"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients = ["tomato", "pasta", "water"]
		let thisRecipe = Recipe(name: "Tomato pasta", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "Recipes returned")
				XCTAssertTrue(resp.first?.name == "Tomato pasta", "Not Found Tomato pasta")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipiesForChickenTikkaMasala() throws {
		/*
		{
		"name" : "Chicken tikka masala",
		"ingredients" : ["chicken", "butter", "onion"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients = ["chicken", "butter", "onion"]
		let thisRecipe = Recipe(name: "Chicken tikka masala", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp.first?.name == "Chicken tikka masala", "Not Found Chicken tikka masala")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipiesForCheesecake() throws {
		/*
		{
		"name" : "Cheesecake",
		"ingredients" : ["biscuit", "butter", "sugar"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients = ["biscuit", "butter", "sugar"]
		let thisRecipe = Recipe(name: "Cheesecake", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp.first?.name == "Cheesecake", "Not Found Cheesecake")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipiesForChocolateBrownie() throws {
		/*
		{
		"name" : "Chocolate brownie",
		"ingredients" : ["chocolate", "butter", "sugar"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients = ["chocolate", "butter", "sugar"]
		let thisRecipe = Recipe(name: "Chocolate brownie", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp.first?.name == "Chocolate brownie", "Not Found Chocolate brownie")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipiesForMeatball() throws {
		/*
		{
		"name" : "Meatball",
		"ingredients" : ["Meat", "parmesan", "onion"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients =  ["Meat", "parmesan", "onion"]
		let thisRecipe = Recipe(name: "Meatball", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp.first?.name == "Meatball", "Not Found Meatball")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetRecipiesForMeatloaf() throws {
		/*
		{
		"name" : "Meatloaf",
		"ingredients" : ["Meat", "egg", "onion"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients = ["Meat", "egg", "onion"]
		let thisRecipe = Recipe(name: "Meatloaf", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp.first?.name == "Meatloaf", "Not Found Meatloaf")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testAllRecipiesForTheseIngredients() throws {

		let testIngredients = [
			"Meat",
			"egg",
			"onion",
			"parmesan",
			"butter",
			"sugar",
			"chicken"
		]

		RecipesService.shared.getRecipes(recipes: self.allRecipes, for: testIngredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 3, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp[0].name == "Chicken tikka masala", "Not Found Chicken tikka masala: \(resp[0].name)")
				XCTAssertTrue(resp[1].name == "Meatball", "Not Found Meatball: \(resp[1].name)")
				XCTAssertTrue(resp[2].name == "Meatloaf", "Not Found Meatloaf: \(resp[2].name)")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testGetForOneBlankIngredient() throws {
		/*
		{
		"name" : "Meatball",
		"ingredients" : ["Meat", "parmesan", "onion"]
		}
		*/
		var recipes = [Recipe]()
		let ingredients =  ["Meat", "parmesan", "", "onion"]
		let thisRecipe = Recipe(name: "Meatball", ingredients: ingredients)
		recipes.append(thisRecipe)

		RecipesService.shared.getRecipes(recipes: recipes, for: ingredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 1, "\(resp.count) Recipes returned")
				XCTAssertTrue(resp[0].name == "Meatball", "Not Found Meatball: \(resp[0].name)")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testForAllBlankIngredients() {
		/*
		biscuit, butter, sugar and chocolate
		*/

		let testIngredients = [
			"",
			"",
			"",
			""
		]

		RecipesService.shared.getRecipes(recipes: self.allRecipes, for: testIngredients) { (resp) in
			switch resp {
			case .success(let resp):
				XCTAssertTrue(resp.count == 0, "\(resp.count) Recipes returned")
			case .failure(let err):
				XCTFail(err.localizedDescription)
			}
		}
	}

	func testCapitaliseIngredients() {

		let testIngredients = [
			"Meat",
			"egg",
			"onion",
			"parmesan",
			"butter",
			"sugar",
			"chicken"
		]

		let expectedResult = [
			"Meat",
			"Egg",
			"Onion",
			"Parmesan",
			"Butter",
			"Sugar",
			"Chicken"
		]

		let capitalisedIngredients = testIngredients.capitalise()

		XCTAssertTrue(capitalisedIngredients == expectedResult, "Expected items to be capitalised")
	}

	func testCapitaliseRecipes() {

		let chocolate = Recipe(name: "Chocolate brownie", ingredients: ["chocolate", "butter", "sugar"])
		let meatball = Recipe(name: "Chicken tikka masala", ingredients: ["chicken", "butter", "onion"])

		let recipes = [chocolate, meatball]

		let expectedResult = [ Recipe(name: "Chocolate Brownie", ingredients: ["Chocolate", "Butter", "Sugar"]),
									  Recipe(name: "Chicken Tikka Masala", ingredients: ["Chicken", "Butter", "Onion"])

		]

		let capitalisedRecipes = recipes.capitalise()

		XCTAssertTrue(capitalisedRecipes == expectedResult, "Expected capitalised recipes")
	}

}
