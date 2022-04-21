//
//  PostCommentsViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 11/04/22.
//

import UIKit

class PostCommentsViewController: UIViewController {
    
    lazy var myPostAndCommentsView = CommentsInPostView()
    let network = NetworkService.shared
    var thread: ThreadIDResponse?
    var subjectName: String
    var subjectID: String
    var subjectImageURL: String
    var commentsId: [Int:String] = [:]
    var threadsId: [Int:String] = [:]
    
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
        loadComments()
        
        myPostAndCommentsView.commentBackButtons.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        myPostAndCommentsView.commentBackButtons.postButton.addTarget(self, action: #selector(postComment(_:)), for: .touchUpInside)
        
        //send to main page
        myPostAndCommentsView.header.labelStackView.addTapGesture {
            let page = MainPageViewController()
            self.navigationController?.setViewControllers([page], animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            addFloatingButton()
            floatingButton?.addTarget(self, action: #selector(floatingButtonPressed), for: .touchUpInside)
    }

    @objc func floatingButtonPressed(){
        let postEditor = PostEditorViewController()
        self.navigationController?.pushViewController(postEditor, animated: true)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postComment(_ sender: UIButton) {
        guard let thread = thread else {
            return
        }

        let page = MakeCommentViewController(thread: thread, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.pushViewController(page, animated: true)
        print("postComment")
    }
    
    func configureView(){
        guard let thread = thread else { return }
        let fullDate = thread.createdAt.prefix(10)
        let day = fullDate.suffix(2)
        let month = fullDate.suffix(5).prefix(2)
        let year = fullDate.prefix(4)
        
        let user = UserID()
        let userId = user.userID
        
        print(userId)
        print(thread.user.id)
        
        if userId != thread.user.id {
            self.myPostAndCommentsView.post.button.isHidden = true
        }  else {
            self.myPostAndCommentsView.post.button.tag += 1
            let buttonTag = self.myPostAndCommentsView.post.button.tag
            self.threadsId[buttonTag] = thread.id
        }
        
        myPostAndCommentsView.post.button.addTarget(self, action: #selector(deleteThreadAlert(_:)), for: .touchUpInside)
        
        myPostAndCommentsView.currentPageLbl.text = "Comentários do Post: \(thread.title)"
        myPostAndCommentsView.post.postInfoLabel.text = "\(thread.user.firstName) \(thread.user.lastName) em \(day)-\(month)-\(year)"
        myPostAndCommentsView.post.postTitleLabel.text = thread.title
        myPostAndCommentsView.post.postContentLabel.text = thread.content
        
        myPostAndCommentsView.numberOfCommentsLabel.text = "\(thread.commentCount) Comentário(s)"
        
        guard let comments = thread.comments else { return }
        
        for comment in 0..<comments.count{
            let commentView = CommentView()
            
            if userId != comments[comment].user.id {
                commentView.button.isHidden = true
            } else {
                commentView.button.tag += 1
                self.commentsId[commentView.button.tag] = comments[comment].id
                print(commentView.button.tag)
                print(comments[comment].id)
                print(self.commentsId as Any)
            }
            
            commentView.button.addTarget(self, action: #selector(deleteCommentAlert(_:)), for: .touchUpInside)
            
            commentView.infoLabel.text = "\(comments[comment].user.firstName) \(comments[comment].user.lastName) em \(day)-\(month)-\(year)"
            commentView.contentLabel.text = comments[comment].content
            
            myPostAndCommentsView.commentsStack.commentsStack.addArrangedSubview(commentView)
        }
    }
    
    func loadComments() {
        network.makeUrlRequest(endpoint: .fetchThreadID(threadID: thread!.id), path: nil, method: .get, header: nil, body: nil, parameters: nil) { (result: Result<ThreadIDResponse, RequestError>) in
            switch result {
            case .success(let successValue):
                self.thread = successValue
                DispatchQueue.main.async {
                    self.configureView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func deleteCommentAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Deletar comentário", message: "Após concluída, esta ação não poderá ser desfeita", preferredStyle: UIAlertController.Style.alert)
        
        let buttonTag = sender.tag
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Deletar", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
            self.deleteComment(buttonTag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteComment(_ buttonTag: Int) {
        guard let commentId = self.commentsId[buttonTag]
        else {
            print("Error finding comment id")
            return
        }
        
        network.makeUrlRequest(endpoint: .deleteComment(commentId: commentId), path: nil, method: .delete, header: nil, body: nil, parameters: nil) { (result: Result<CreatedComment, RequestError>) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    guard let thread = self.thread else { return }
                    
                    let page = PostCommentsViewController(thread: thread, subjectName: self.subjectName, subjectID: self.subjectID, subjectImageURL: self.subjectImageURL)
                    
                    self.navigationController?.pushViewController(page, animated: true)
                    print("returned sucessfully to thread page")
                }
                print("Comment deleted successfully")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func deleteThreadAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Deletar postagem", message: "Após concluída, esta ação não poderá ser desfeita", preferredStyle: UIAlertController.Style.alert)
        
        let buttonTag = sender.tag
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: {(_: UIAlertAction!) in
            print("button pressed on thread")
        }))
        
        alert.addAction(UIAlertAction(title: "Deletar", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
            self.deleteThread(buttonTag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteThread(_ buttonTag: Int) {
        guard let threadId = self.threadsId[buttonTag]
        else {
            print("Error finding thread id")
            return
        }
        
        network.makeUrlRequest(endpoint: .deleteThread(threadId: threadId), path: nil, method: .delete, header: nil, body: nil, parameters: nil) { (result: Result<CreatedComment, RequestError>) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let page = MainPageViewController()
                    self.navigationController?.pushViewController(page, animated: true)
                    print("returned sucessfully to thread page")
                }
                print("Post deleted successfully")
            case .failure(let error):
                print(error)
            }
        }
    }
}

