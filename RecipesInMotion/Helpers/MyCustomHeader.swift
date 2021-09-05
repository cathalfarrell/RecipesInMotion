//
//  MyCustomHeader.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 02/09/2021.
//
// swiftlint:disable line_length
// SOURCE: https://developer.apple.com/documentation/uikit/views_and_controls/table_views/adding_headers_and_footers_to_table_sections

import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {

	let title = UILabel()
	let image = UIImageView()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		configureContents()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureContents() {
		image.translatesAutoresizingMaskIntoConstraints = false
		title.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill

		contentView.addSubview(image)
		contentView.addSubview(title)

		contentView.clipsToBounds = true

		// Center the image vertically and place it near the leading
		// edge of the view. Constrain its width and height to 50 points.
		NSLayoutConstraint.activate([
//			image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//			image.widthAnchor.constraint(equalToConstant: 50),
//			image.heightAnchor.constraint(equalToConstant: 50),
//			image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			image.topAnchor.constraint(equalTo: contentView.topAnchor),
			image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			// Center the label vertically, and use it to fill the remaining
			// space in the header view.
			title.heightAnchor.constraint(equalToConstant: 30),
			title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
										   constant: 8),
			title.trailingAnchor.constraint(equalTo:
												contentView.layoutMarginsGuide.trailingAnchor),
			title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}

}
