//
//  ImageWithGradientBottom.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 04/09/21.
//  Copyright © 2021 Cathal Productions. All rights reserved.
//

import UIKit

/// Creates an imageview with a grdient layer

@IBDesignable
class ImageWithGradientBottom: UIImageView {

	let myGradientLayer: CAGradientLayer

	var gradientColor: UIColor = UIColor.black

	override init(frame: CGRect) {
		myGradientLayer = CAGradientLayer()
		super.init(frame: frame)
		self.setup()
	}

	required init(coder aDecoder: NSCoder) {
		myGradientLayer = CAGradientLayer()
		super.init(coder: aDecoder)!
		self.setup()
	}

	func setup() {
		myGradientLayer.frame.size = self.frame.size
		myGradientLayer.frame.origin = self.frame.origin

		let topColor = gradientColor.withAlphaComponent(0.1).cgColor
		let secondColor = gradientColor.withAlphaComponent(0.7).cgColor
		let thirdColor = gradientColor.withAlphaComponent(0.8).cgColor
		let bottomColor = gradientColor.withAlphaComponent(0.9).cgColor

		myGradientLayer.colors = [topColor, secondColor, thirdColor, bottomColor]
		myGradientLayer.locations = [0.2, 0.8, 0.9, 1.0] /*top*/
		myGradientLayer.isOpaque = false
		self.layer.addSublayer(myGradientLayer)
	}

	override func layoutSubviews() {
		myGradientLayer.frame = self.layer.bounds
	}
}
