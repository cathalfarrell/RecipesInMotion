//
//  AllRecipesRouter.swift
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

@objc protocol AllRecipesRoutingLogic {
	// func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AllRecipesDataPassing {
	var dataStore: AllRecipesDataStore? { get }
}

class AllRecipesRouter: NSObject, AllRecipesRoutingLogic, AllRecipesDataPassing {
	weak var viewController: AllRecipesViewController?
	var dataStore: AllRecipesDataStore?

	// MARK: Routing
	/*
	func routeToSomewhere(segue: UIStoryboardSegue?)
	{
	if let segue = segue {
	let destinationVC = segue.destination as! SomewhereViewController
	var destinationDS = destinationVC.router!.dataStore!
	passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	} else {
	let storyboard = UIStoryboard(name: "Main", bundle: nil)
	let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController")
	as! SomewhereViewController
	var destinationDS = destinationVC.router!.dataStore!
	passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	navigateToSomewhere(source: viewController!, destination: destinationVC)
	}
	}
	*/
	// MARK: Navigation
	/*
	func navigateToSomewhere(source: AllRecipesViewController, destination: SomewhereViewController)
	{
	source.show(destination, sender: nil)
	}
	
	// MARK: Passing data
	
	func passDataToSomewhere(source: AllRecipesDataStore, destination: inout SomewhereDataStore)
	{
	destination.name = source.name
	}
	*/
}
