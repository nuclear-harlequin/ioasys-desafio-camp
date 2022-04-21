//
//  ViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 04/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var myWelcomeView = welcomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myWelcomeView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        myWelcomeView.loginButton.longButton.addTarget(self, action: #selector(goToLogin(_:)), for: .touchUpInside)
        myWelcomeView.signupButton.longButton.addTarget(self, action: #selector(takeToSignUpPage(_:)), for: .touchUpInside)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        self.navigationController?.setViewControllers([loginViewController], animated: true)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    @IBAction func takeToSignUpPage(_ sender: UIButton) {
        if let url = URL(string: "https://tamo-junto.vercel.app/") {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

