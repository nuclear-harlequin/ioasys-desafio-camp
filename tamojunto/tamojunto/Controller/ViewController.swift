//
//  ViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 04/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    lazy var myHomeView = PostEditorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myHomeView.buttonsStack.postButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }

    @IBAction func login(_ sender: UIButton) {
        let tabBarController = TabBarController()
        self.navigationController?.setViewControllers([tabBarController], animated: true)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myHomeView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        
        
        
    }
    
}

