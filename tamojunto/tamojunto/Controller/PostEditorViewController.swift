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
    lazy var subjectsDict:[String:String] = ["Administração" : "32dd929b-d4e9-460a-9a12-c4dc0ade5daf", "Aluguel, compra e venda": "2c5c974d-133f-4a02-8c7b-b51267e6e302", "Colaboradores": "c3847b3f-4681-49fc-a52e-0d4c0b778a8f", "Estudos": "dd278e0e-7662-4671-906f-2deb5e6f6fcf","Finanças" : "826165a0-69f7-4b0a-b222-28d35d165819", "Fornecedores":  "76e9fc20-0afe-4b0c-befe-fcec16c0f72f", "Happy Hour" : "bd3231da-6756-4461-a4df-4dd357934028", "Inovação": "1e6e3211-c0ca-480e-bc23-2017b70905a7", "Marketing": "961f0486-1ff0-45e3-b860-baab867b7bfa", "Notícias": "94417693-72ad-41d0-b86a-c47c9dc28d4c"]
    lazy var selectedSubject = ""
    
    
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
        myPostEditorView.subjectMenuButton.addTarget(self, action: #selector(showDropDown(_:)), for: .touchUpInside)
        
        myPostEditorView.dropdown.dataSource = Array(subjectsDict.keys)

    }
    
    @IBAction func goBack(_ sender: UIButton) {
        let page = MainPageViewController()
        self.navigationController?.setViewControllers([page], animated: true)
        print("goingback")
    }
    
    @IBAction func showDropDown(_ sender: UIButton) {
        myPostEditorView.dropdown.show()
        myPostEditorView.dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectedSubject = item
            myPostEditorView.subjectMenuButton.setTitle("\(item)", for: .normal)
          print("Selected item: \(item) at index: \(index)")
            
        }
        print("dropdown")
    }
    
    @IBAction func postThread(_ sender: UIButton) {
        //postar thread e levar user para pagina da thread postada
        //@GIOVANNA
    }
}

extension PostEditorViewController {
    func postThread() {
        let threadTitle: String? = myPostEditorView.titleTextField.titleTextField.text
        let threadContent: String? = myPostEditorView.messageTextField.messageTextField.text
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



