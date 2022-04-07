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
        
        let controller1 = PostEditorViewController()
        controller1.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = PostEditorViewController()
        controller2.tabBarItem = UITabBarItem(title: "Novo Tópico", image: UIImage(systemName: "plus.square"), selectedImage: UIImage(systemName: "plus.square.fill"))
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = PostEditorViewController()
        controller3.tabBarItem = UITabBarItem(title: "Configurações", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        let nav3 = UINavigationController(rootViewController: controller3)
        
        let controller4 = CommentViewController()
        controller4.tabBarItem = UITabBarItem(title: "Comentar", image: UIImage(systemName: "plus.bubble"), selectedImage: UIImage(systemName: "plus.bubble.fill"))
        let nav4 = UINavigationController(rootViewController: controller4)

        viewControllers = [nav1, nav2, nav4, nav3]
    }
    
    
}
