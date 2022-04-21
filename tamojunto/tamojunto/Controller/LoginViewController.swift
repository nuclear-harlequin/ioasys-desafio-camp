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
    let network = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myLoginView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        myLoginView.loginButton.longButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        myLoginView.signupButton.addTarget(self, action: #selector(takeToSignUpPage(_:)), for: .touchUpInside)
    }
    
    @IBAction func login(_ sender: UIButton) {
        performLoginServer()
    }
    
    @IBAction func takeToSignUpPage(_ sender: UIButton) {
        if let url = URL(string: "https://www.apple.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func performLoginServer() {
        let email = self.myLoginView.emailTextField.titleTextField.text ?? ""
        let pass = self.myLoginView.passwordTextField.titleTextField.text ?? ""

        let body = ["email": email, "password": pass]
        let encodedBody = self.network.encodeToJSON(data: body)
        
            print("comecando network")
            network.makeUrlRequest(endpoint: .userLogin, path: nil, method: .post, header: nil, body: encodedBody, parameters: nil) { (result: Result<LoginResponse, RequestError>) in
                switch result {
                case .success(let loginResponse):
                    print(loginResponse)
                    DispatchQueue.main.async {
    
                        let userID = UserID()
                        let userToken = UserToken()
                        
                        userID.userID = loginResponse.user.id
                        userToken.userToken = loginResponse.accessToken

                        
                        let mainPageView = MainPageViewController()
                        self.navigationController?.setViewControllers([mainPageView], animated: true)
                        self.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.isToolbarHidden = true
                        self.navigationController?.hidesBarsOnSwipe = true
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

