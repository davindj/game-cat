//
//  MainTabBarController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/10/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.primaryColor
        
        let homevc = HomeViewController()
        let homenavvc = UINavigationController(rootViewController: homevc)
        let homeTabBarItem = UITabBarItem(title: "Game", image: UIImage(systemName: "gamecontroller"), tag: 0)
        homeTabBarItem.selectedImage = UIImage(systemName: "gamecontroller.fill")
        homenavvc.tabBarItem = homeTabBarItem
        homenavvc.navigationBar.tintColor = UIColor.primaryColor
        addChild(homenavvc)
        
        let favvc = FavoriteViewController()
        let favnavvc = UINavigationController(rootViewController: favvc)
        let favTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        favTabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favnavvc.tabBarItem = favTabBarItem
        favnavvc.navigationBar.tintColor = UIColor.primaryColor
        addChild(favnavvc)
    }
}
