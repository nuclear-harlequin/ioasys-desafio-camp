//
//  MakeCommentViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class MakeCommentViewController: UIViewController, UITextViewDelegate {
    var textViewClearedOnInitialEdit = false
    
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
        guard let thread = thread else {
            return
        }
//postar comentario e levar user para pagina
        //@GIOVANNA
        let page = PostCommentsViewController(thread: thread, subjectName: subjectName, subjectID: subjectID, subjectImageURL:subjectImageURL)
        self.navigationController?.setViewControllers([page], animated: true)
        print("ppostingcomment")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textViewClearedOnInitialEdit {
            myMakeCommentView.comment.messageTextField.text = ""
            textViewClearedOnInitialEdit = true
        }
    }
}
