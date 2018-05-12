//
//  AppDelegate.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        styleApp()
        return true
    }

    fileprivate func styleApp() {
        UIApplication.shared.statusBarStyle = .lightContent
        UITabBar.appearance().barTintColor = UIColor.mainColor
        UINavigationBar.appearance().barTintColor = UIColor.mainColor
        UITabBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Get Schwifty", size: 34.0)!, NSAttributedStringKey.foregroundColor: UIColor.rickAndMortyTitleBlue]
    }
}
