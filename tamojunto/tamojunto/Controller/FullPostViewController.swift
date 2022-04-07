//
//  FullPostViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 07/04/22.
//

import Foundation
import UIKit

class FullPostViewController: UIViewController{
    lazy var myFullPostView = FullPostView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func loadView() {
        super.loadView()
        
        self.view = myFullPostView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
    }
}


