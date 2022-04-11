//
//  SearchSuccessViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class SearchSuccessViewController: UIViewController{
    lazy var mySearchResults = SearchSuccessView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func loadView() {
        super.loadView()
        
        self.view = mySearchResults
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
    }
}
