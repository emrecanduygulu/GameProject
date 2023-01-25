//
//  TabBar.swift
//  GameProject
//
//  Created by emre can duygulu on 21.01.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.barTintColor = .darkTeal
        tabBar.tintColor = .lightPink
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .darkTeal
        
        viewControllers = TabBarItems.allCases.map {
            $0.controller
        }
            selectedIndex = 0
    }
}
