//
//  AppDelegate.swift
//  RecipesInMotion
//
//  Created by Cathal Farrell on 31/08/2021.
//
// swiftlint:disable vertical_parameter_alignment

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	fileprivate func customiseAppearance() {
		// Override point for customization after application launch.
		let tabBarFont = UIFont.systemFont(ofSize: 10, weight: .bold)
		UITabBar.appearance().barTintColor = .black
		UITabBar.appearance().tintColor = .white

		UITabBarItem.appearance().setTitleTextAttributes([
			NSAttributedString.Key.font: tabBarFont
		], for: .normal)
	}

	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		customiseAppearance()

		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication,
					 configurationForConnecting connectingSceneSession: UISceneSession,
					 options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}

}
