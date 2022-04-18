//
//  PostEditorViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class PostEditorViewController: UIViewController, UITextViewDelegate {
    var textViewClearedOnInitialEdit = false
    
    lazy var myPostEditorView = PostEditorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPostEditorView.messageTextField.messageTextField.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myPostEditorView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        
        myPostEditorView.buttonsStack.postButton.addTarget(self, action: #selector(postThread(_:)), for: .touchUpInside)
        myPostEditorView.buttonsStack.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)

    }
    
    @IBAction func goBack(_ sender: UIButton) {
        let page = MainPageViewController()
        self.navigationController?.setViewControllers([page], animated: true)
        print("goingback")
    }
    
    @IBAction func postThread(_ sender: UIButton) {
        //postar thread e levar user para pagina da thread postada
        //@GIOVANNA
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textViewClearedOnInitialEdit {
            myPostEditorView.messageTextField.messageTextField.text = ""
            textViewClearedOnInitialEdit = true
        }
    }
}



