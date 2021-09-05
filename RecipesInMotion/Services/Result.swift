//
//  Result.swift
//  RecipiesInMotion
//
//  Created by Cathal Farrell on 31/08/2021.
//  Copyright © 2021 RecipiesInMotion. All rights reserved.
//

import Foundation

enum Result<T> {

	case success(T)
	case failure(Error)
}
