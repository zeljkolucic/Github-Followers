//
//  TabBarController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 10.3.22..
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
    }

    private func configureTabBarController() {
        UITabBar.appearance().tintColor = .systemGreen
        
        configureTabBarAppearance()
        configureNavigationBarAppearance()
        
        let searchNavigationController = createSearchNavigationController()
        let favoritesNavigationController = createFavoritesNavigationController()
        viewControllers = [searchNavigationController, favoritesNavigationController]
    }
    
    private func configureTabBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func configureNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = .systemGreen
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        return searchNavigationController
    }
    
    fileprivate func createFavoritesNavigationController() -> UINavigationController {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        return favoritesNavigationController
    }
    
}
