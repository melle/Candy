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
        window?.rootViewController = LoginVC()
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }

}

