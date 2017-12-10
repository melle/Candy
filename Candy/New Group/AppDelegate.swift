//
//  AppDelegate.swift
//  Candy
//
//  Created by SimpuMind on 11/28/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = CustomTabBarController()
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }

}

