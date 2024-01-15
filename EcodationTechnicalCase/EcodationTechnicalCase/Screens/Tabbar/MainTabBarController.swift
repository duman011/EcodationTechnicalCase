//
//  MainTabBarController.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class MainTabBarController : UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Tab bar arka plan rengi
        tabBar.backgroundColor = .tertiarySystemBackground
        
        // Seçili olan öğelerin rengi
        tabBar.tintColor = .label

        // Seçilmeyen öğelerin rengi
        tabBar.unselectedItemTintColor = .systemGray

        viewControllers = [
            createSearchNC(),
            createWatchListNC(),
            FavoritesNC()
        ]
    }
    
    // MARK: - Searc Navigation Controller 🔍
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(systemName: "magnifyingglass"),
                                         selectedImage: UIImage(systemName: "magnifyingglass"))
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // MARK: - WatchList Navigation Controller 🎥
    private func createWatchListNC() -> UINavigationController {
        let watchListVC = WatchListVC()
        
        watchListVC.tabBarItem = UITabBarItem(title: "WatchList",
                                          image: UIImage(systemName: "list.star"),
                                          selectedImage: UIImage(systemName: "list.star"))
        
        return UINavigationController(rootViewController: watchListVC)
    }
    
    // MARK: - Favorites Navigation Controller ⭐️
    private func FavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites",
                                         image: UIImage(systemName: "suit.heart"),
                                         selectedImage: UIImage(systemName: "suit.heart.fill"))
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
}
