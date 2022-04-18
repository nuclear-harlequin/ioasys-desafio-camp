//
//  PostEditorViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class PostEditorViewController: UIViewController {
    var textViewClearedOnInitialEdit = false
    let network = NetworkService.shared
    
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
    }
}

extension PostEditorViewController {
    func postThread() {
        let threadTitle = myPostEditorView.titleTextField.titleTextField.text
        let threadContent = myPostEditorView.messageTextField.messageTextField.text
        
        guard let threadTitle = threadTitle
        else {
            print("Thread must contain title")
            return
        }
        
        guard let threadContent = threadContent
        else {
            print("Thread must contain body")
            return
        }
        
        network.makeUrlRequest(endpoint: .fetchThreads, path: nil, method: .post, header: nil, body: <#T##Data?#>, parameters: nil, resultHandler: <#T##(Result<Decodable, RequestError>) -> Void#>)
        
    }
}

extension PostEditorViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textViewClearedOnInitialEdit {
            myPostEditorView.messageTextField.messageTextField.text = ""
            textViewClearedOnInitialEdit = true
        }
    }
}

