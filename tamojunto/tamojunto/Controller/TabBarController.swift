//
//  TabBarController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    var myBookmarkedBooks = PostEditorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
       
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = UIColor(red: 0.05, green: 0.29, blue: 0.31, alpha: 1.00)
        

        let controller1 = MainPageViewController()
        controller1.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = PostEditorViewController()
        controller2.tabBarItem = UITabBarItem(title: "Novo Tópico", image: UIImage(systemName: "plus.square"), selectedImage: UIImage(systemName: "plus.square.fill"))
        let nav2 = UINavigationController(rootViewController: controller2)
        
        viewControllers = [nav1, nav2]
    }
    
    
}
