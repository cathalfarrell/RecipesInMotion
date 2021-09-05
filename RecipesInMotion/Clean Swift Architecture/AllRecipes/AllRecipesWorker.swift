//
//  AllRecipesWorker.swift
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

class AllRecipesWorker {

	func getAllRecipes(completionHandler:@escaping ([Recipe]?, Error?) -> Void) {

		RecipesService.shared.getRecipes { (resp) in
			switch resp {
			case .success(let resp):
				completionHandler(resp, nil)
			case .failure(let err):
				completionHandler(nil, err)
			}
		}
	}
}
