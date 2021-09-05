//
//  IngredientsService.swift
//  RecipiesInMotion
//
//  Created by Cathal Farrell on 31/08/2021.
//  Copyright © 2021 RecipiesInMotion. All rights reserved.
//

import Foundation
import Alamofire

typealias APIResponseIngredients = [String]

struct IngredientsService {

	static let shared = IngredientsService()

	func getAvailableIngredients(_ completion: @escaping (Result<APIResponseIngredients>) -> Void) {

		let url = "https://run.mocky.io/v3/45a5a07f-e981-4918-9c31-090b121d6c5f"

		do {
			Log.v("😀 Making this request: \(url)")

			let request = AF.request(url)

			request.responseJSON { response in

				/*
				print("REQUEST: \(response.request)")  // original url request
				print("RESPONSE: \(response.response)")   // http url response
				print("RESULT: \(response.result)")    // response serialization result
				*/

				switch response.result {

				case .success:

					if let unwrappedData = response.data {
						do {
							let jsonResult = try JSONDecoder().decode(APIResponseIngredients.self, from: unwrappedData)
							// print("RESULT: \(String(describing: jsonResult))")
							Log.v("Successfully parsed result")
							completion(Result.success(jsonResult))
						} catch let err {
							Log.e("Unable to parse JSON response: \(err.localizedDescription)")
							completion(Result.failure(err))
						}

						// self.printAPIResponse(data: unwrappedData)
					}
				case .failure(let err):
					Log.e("FAILED: \(response.result) error:\(err)")
					completion(Result.failure(err))
				}
			}
		}
	}

	func printAPIResponse(data: Data) {
		// Just for test print purposes
		do {
			let resultObject = try JSONSerialization.jsonObject(with: data, options: [])
			Log.v("Results from request:\n\(resultObject)")
		} catch let err {
			Log.e("Unable to parse JSON response: \(err.localizedDescription)")
		}
	}
}
