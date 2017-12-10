//
//  MainVC.swift
//  Candy
//
//  Created by SimpuMind on 12/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let button = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        button.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        
        button.addTarget(self, action: #selector(presentToInputVC), for: .touchUpInside)
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        
        tabBarAppearance.barTintColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        setupBarItems()
    }
    
    @objc func presentToInputVC(){
        let vc = InputTaskVC()
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
        button.layer.cornerRadius = 32
    }
    
    private func setupBarItems(){
        let controller1 = ListVC()
        controller1.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "list_line"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        nav1.toolbar.isHidden = true
        
        let controller2 = UIViewController()
        controller2.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "clock_line"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = UIViewController()
        controller3.tabBarItem = UITabBarItem(title: "", image: nil, tag: 3)
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""
        
        let controller4 = UIViewController()
        controller4.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "bell_line"), tag: 4)
        let nav4 = UINavigationController(rootViewController: controller4)
        
        let controller5 = UIViewController()
        controller5.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "user_line"), tag: 5)
        let nav5 = UINavigationController(rootViewController: controller5)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
    }

}
