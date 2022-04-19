//
//  PostCommentsViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 11/04/22.
//

import UIKit

class PostCommentsViewController: UIViewController {
    
    lazy var myPostAndCommentsView = CommentsInPostView()
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
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myPostAndCommentsView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        for view in myPostAndCommentsView.commentsStack.commentsStack.arrangedSubviews{
            view.removeFromSuperview()
        }
        configureView()
        
        myPostAndCommentsView.commentBackButtons.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        myPostAndCommentsView.commentBackButtons.postButton.addTarget(self, action: #selector(postComment(_:)), for: .touchUpInside)
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

        let page = MakeCommentViewController(thread: thread, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.setViewControllers([page], animated: true)
        print("postComment")
    }
    
    func configureView(){
        guard let thread = thread else { return }
        
        myPostAndCommentsView.currentPageLbl.text = "Comentários do Post: \(thread.title)"
        myPostAndCommentsView.post.postInfoLabel.text = "\(thread.user.firstName) \(thread.user.lastName) em \(thread.createdAt)"
        myPostAndCommentsView.post.postTitleLabel.text = thread.title
        myPostAndCommentsView.post.postContentLabel.text = thread.content
        
        myPostAndCommentsView.numberOfCommentsLabel.text = "\(thread.commentCount) Comentário(s)"
        
        guard let comments = thread.comments else { return }
        
        for comment in 0..<comments.count{
            let commentView = CommentView()
            commentView.infoLabel.text = "\(comments[comment].user.firstName) \(comments[comment].user.lastName) em \(comments[comment].createdAt)"
            
            commentView.contentLabel.text = comments[comment].content
            
            myPostAndCommentsView.commentsStack.commentsStack.addArrangedSubview(commentView)
        }
    }
    
}

