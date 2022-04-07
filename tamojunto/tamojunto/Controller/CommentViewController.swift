//
//  CommentViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class CommentViewController: UIViewController {
    
    lazy var myHomeView = MakeCommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myHomeView
    }
}
