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
    var createdThread: CreatedThread?

    let network = NetworkService.shared
    
    lazy var myPostEditorView = PostEditorView()    
    lazy var subjectsDict = Dictionaries().subjectsDict
    lazy var pictureURLDict = Dictionaries().pictureURLDict
    
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
        print("Going back")
    }
    
    @IBAction func showDropDown(_ sender: UIButton) {
        myPostEditorView.dropdown.show()
        myPostEditorView.dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectedSubject = item
            myPostEditorView.subjectMenuButton.setTitle("\(selectedSubject)", for: .normal)
          print("Selected item: \(selectedSubject) at index: \(index)")
        }
        print("dropdown")
    }
    
    @IBAction func postThread(_ sender: UIButton) {
        postNewThread()
        
//        let threadId = self.createdThread?.id
//        let subjectId = self.subjectsDict[self.selectedSubject]
//
//        print(self.selectedSubject)
//
//        guard let threadId = threadId
//        else {
//            print("Invalid thread id")
//            return
//        }
//        print(threadId)
//
//        guard let subjectId = subjectId
//        else {
//            print("Invalid subject id")
//            return
//        }
//        print(subjectId)
//
//        let subjectImage = self.pictureURLDict[subjectId]
//
//        guard let subjectImage = subjectImage
//        else {
//            print("Invalid subject image")
//            return
//        }
//        print(subjectImage)
        
//        let page = FullPostViewController(threadID: threadId, subjectName: self.selectedSubject, subjectID: subjectId, subjectImageURL: subjectImage)
//        //  present(page, animated: true, completion: nil)
//        self.navigationController?.setViewControllers([page], animated: true)
    }
}

extension PostEditorViewController {
    func postNewThread() {
        let threadTitle: String? = myPostEditorView.titleTextField.titleTextField.text
        let threadContent: String? = myPostEditorView.messageTextField.messageTextField.text
        let subjectId: String? = subjectsDict[selectedSubject]
        
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
            print("Invalid subject")
            return
        }
        
        let body = ["title": threadTitle, "content": threadContent, "subjectId": subjectId]
        let encodedBody = network.encodeToJSON(data: body)
        
        network.makeUrlRequest(endpoint: .fetchThreads, path: nil, method: .post, header: nil, body: encodedBody, parameters: nil) { (result: Result<CreatedThread, RequestError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.createdThread = response
                    print(response)
                    print("Thread created successfully")
                    
                    let threadId = self.createdThread?.id
                    let subjectId = self.subjectsDict[self.selectedSubject]
                                    
                    guard let threadId = threadId
                    else {
                        print("Invalid thread id")
                        return
                    }
                    
                    guard let subjectId = subjectId
                    else {
                        print("Invalid subject id")
                        return
                    }
                    
                    let subjectImage = self.pictureURLDict[subjectId]
                    
                    guard let subjectImage = subjectImage
                    else {
                        print("Invalid subject image")
                        return
                    }
                    
                    let page = FullPostViewController(threadID: threadId, subjectName: self.selectedSubject, subjectID: subjectId, subjectImageURL: subjectImage)
                    //  present(page, animated: true, completion: nil)
                    self.navigationController?.setViewControllers([page], animated: true)
                    
                case .failure(let error):
                    print(error)
                }
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



