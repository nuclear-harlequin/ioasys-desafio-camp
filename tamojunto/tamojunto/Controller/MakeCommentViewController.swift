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
        
        let fullDate = thread.createdAt.prefix(10)
        let day = fullDate.suffix(2)
        let month = fullDate.suffix(5).prefix(2)
        let year = fullDate.prefix(4)
        
        myMakeCommentView.currentPageLbl.text = "\(subjectName) > \(thread.title)"
        myMakeCommentView.post.postInfoLabel.text = " \(thread.user.firstName) \(thread.user.lastName) em \(day)-\(month)-\(year)"
        myMakeCommentView.post.postTitleLabel.text = thread.title
        myMakeCommentView.post.postContentLabel.text = thread.content
        
        //send to main page
        myMakeCommentView.header.labelStackView.addTapGesture {
            let page = MainPageViewController()
            self.navigationController?.setViewControllers([page], animated: true)
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postComment(_ sender: UIButton) {
        postNewComment()
    }
}

extension MakeCommentViewController {
    func postNewComment() {
        let content = myMakeCommentView.comment.messageTextField.text
        let threadId = thread?.id
        
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
        let encodedBody = self.network.encodeToJSON(data: body)
        
        network.makeUrlRequest(endpoint: .writeComment, path: nil, method: .post, header: nil, body: encodedBody, parameters: nil) { (result: Result<CreatedComment, RequestError>) in
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let thread = self.thread else { return }
                    
                    let page = PostCommentsViewController(thread: thread, subjectName: self.subjectName, subjectID: self.subjectID, subjectImageURL: self.subjectImageURL)
                    
                    self.navigationController?.pushViewController(page, animated: true)
                    print("postingcomment")
                    print(response)
                    print("Thread created successfully")
                }
            case .failure(let error):
                print(error)
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let character = text.first, character.isNewline {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
