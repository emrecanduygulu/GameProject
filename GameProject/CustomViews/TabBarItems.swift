//
//  TabBarItems.swift
//  GameProject
//
//  Created by emre can duygulu on 21.01.2023.
//

import UIKit

enum TabBarItems: Int, CaseIterable {
    case home, favorites, notedGames
    
    var controller: UIViewController {
        switch self {
        case .home:
            let tabBarItem = UITabBarItem(title: "home".localized(), image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
            let controller = ListViewController()
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem = tabBarItem
            return navigationController
            
        case .favorites:
            let tabBarItem = UITabBarItem(title: "favorites".localized(), image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
            let controller = FavoritesViewController()
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem = tabBarItem
            return navigationController
            
        case .notedGames:
            let tabBarItem = UITabBarItem(title: "noted_games".localized(), image: UIImage(systemName: "note.text"), selectedImage: UIImage(systemName: "note.text"))
            let controller = NotedGamesViewController()
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
    }
}
