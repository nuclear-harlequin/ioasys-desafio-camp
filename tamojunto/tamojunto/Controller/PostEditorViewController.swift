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
        
        postThread()
    }
}

extension PostEditorViewController {
    func postThread() {
        let threadTitle: String? = "Estou tentando criar um thread"//myPostEditorView.titleTextField.titleTextField.text
        let threadContent: String? = "Esse é o conteúdo do thread"//myPostEditorView.messageTextField.messageTextField.text
        let subjectId: String? = "32dd929b-d4e9-460a-9a12-c4dc0ade5daf"
        
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
        
        guard let subjectId = subjectId
        else {
            print("Choose subject where you want to post the thread")
            return
        }
        
        let body = ["title": threadTitle, "content": threadContent, "subjectId": subjectId]
        let encodedBody = network.encodeToJSON(data: body)
        
        network.makeUrlRequest(endpoint: .fetchThreads, path: nil, method: .post, header: nil, body: encodedBody, parameters: nil) { (result: Result<CreatedThread, RequestError>) in
            switch result {
            case .success:
                print("Thread created successfully")
            case .failure(let error):
                print(error)
            }
        }
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

