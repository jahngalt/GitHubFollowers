//
//  MainTabBar.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/3/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        settingTabBar()
        // Do any additional setup after loading the view.
    }
    
    
    func setupViewControllers() {
        viewControllers = [
            generateNavigationController(with: SearchVC(), title: "Search", tabBarSystemItem: .search, tag: 0),
            generateNavigationController(with: FavoritesListVC(), title: "Favorites", tabBarSystemItem: .favorites, tag: 1)
        ]
    }
    
    
    //MARK:-Helper Functions
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, tabBarSystemItem: UITabBarItem.SystemItem, tag: Int) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
        
        return navController
    }
    
    
    fileprivate func settingTabBar() {
        UITabBar.appearance().tintColor = .systemGreen
    }

}
