//
//  LoginViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 19/04/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    lazy var myLoginView = loginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myLoginView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        myLoginView.loginButton.longButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("clicked")
        let tabBarController = TabBarController()
        self.navigationController?.setViewControllers([tabBarController], animated: true)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
}

