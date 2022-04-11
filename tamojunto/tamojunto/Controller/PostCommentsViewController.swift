//
//  PostCommentsViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 11/04/22.
//

import UIKit

class PostCommentsViewController: UIViewController {
    
    lazy var myHomeView = CommentsInPostView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myHomeView
    }
    
}

