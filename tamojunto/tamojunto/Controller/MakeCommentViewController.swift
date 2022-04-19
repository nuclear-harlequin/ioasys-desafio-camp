//
//  MakeCommentViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class MakeCommentViewController: UIViewController {
    var textViewClearedOnInitialEdit = false
    
    let network = NetworkService.shared
    
    lazy var myMakeCommentView = MakeCommentView()
    var thread: ThreadIDResponse?
    var subjectName: String
    var subjectID: String
    var subjectImageURL: String
    
    init(thread: ThreadIDResponse, subjectName: String, subjectID: String, subjectImageURL: String){
        self.thread = thread
        self.subjectName = subjectName
        self.subjectID = subjectID
        self.subjectImageURL = subjectImageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMakeCommentView.comment.messageTextField.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        self.view = myMakeCommentView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        myMakeCommentView.sendCancelButtons.postButton.addTarget(self, action: #selector(postComment(_:)), for: .touchUpInside)
        myMakeCommentView.sendCancelButtons.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        guard let thread = thread else {
            return
        }
        myMakeCommentView.currentPageLbl.text = "\(subjectName) > \(thread.title)"
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        guard let thread = thread else {
            return
        }

        let page = FullPostViewController(threadID: thread.id, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.setViewControllers([page], animated: true)
        print("goingback")
    }
    
    @IBAction func postComment(_ sender: UIButton) {
        postNewComment()
    }
}

extension MakeCommentViewController {
    func postNewComment() {
        let content = myMakeCommentView.comment.messageTextField.text
        let threadId = self.thread?.id
       
        guard let content = content
        else {
            print("Comment must have content")
            return
        }
        
        guard let threadId = threadId
        else {
            print("Invalid thread")
            return
        }
        
        let body = ["content": content, "threadId": threadId]
        let encodedBody = network.encodeToJSON(data: body)
        
        network.makeUrlRequest(endpoint: .writeComment, path: nil, method: .post, header: nil, body: encodedBody, parameters: nil) { (result: Result<CreatedComment, RequestError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    guard let thread = self.thread else { return }
                    
                    let page = PostCommentsViewController(thread: thread, subjectName: self.subjectName, subjectID: self.subjectID, subjectImageURL: self.subjectImageURL)
                    
                    self.navigationController?.setViewControllers([page], animated: true)
                    print("postingcomment")
                    print(response)
                    print("Thread created successfully")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension MakeCommentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textViewClearedOnInitialEdit {
            myMakeCommentView.comment.messageTextField.text = ""
            textViewClearedOnInitialEdit = true
        }
    }
}
