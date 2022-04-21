//
//  FullPostViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 07/04/22.
//

import Foundation
import UIKit

class FullPostViewController: UIViewController{
    lazy var myFullPostView = FullPostView()
    let network = NetworkService.shared
    var thread: ThreadIDResponse?
    var threadID: String
    var subjectName: String
    var subjectID: String
    var subjectImageURL: String
    var threadsId: [Int:String] = [:]
    
    init(threadID: String, subjectName: String, subjectID: String, subjectImageURL: String){
        self.threadID = threadID
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
        self.navigationController?.isNavigationBarHidden = true
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

    override func loadView() {
        super.loadView()
        
        self.view = myFullPostView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        loadThread()
        
        myFullPostView.buttonsStack.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        myFullPostView.buttonsStack.postButton.addTarget(self, action: #selector(postComment(_:)), for: .touchUpInside)
        myFullPostView.showCommentsButton.longButton.addTarget(self, action: #selector(showComments(_:)), for: .touchUpInside)
        
        //send to main page
        myFullPostView.header.labelStackView.addTapGesture {
            let page = MainPageViewController()
            self.navigationController?.setViewControllers([page], animated: true)
        }
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
    
    @IBAction func showComments(_ sender: UIButton) {
        guard let thread = thread else {
            return
        }

        let page = PostCommentsViewController(thread: thread, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.pushViewController(page, animated: true)
        print("showComments")
    }
    
    func loadThread() {
        network.makeUrlRequest(endpoint: .fetchThreadID(threadID: threadID), path: nil, method: .get, header: nil, body: nil, parameters: nil) { (result: Result<ThreadIDResponse, RequestError>) in
            switch result {
            case .success(let successValue):
                self.thread = successValue
                DispatchQueue.main.async {
                    self.configureThreadView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureThreadView(){
        guard let safeThread = self.thread else {
            return
        }
        
        let user = UserID()
        let userId = user.userID
        
        print(userId)
        print(safeThread.user.id)
        
        if userId != safeThread.user.id {
            self.myFullPostView.postView.button.isHidden = true
        } else {
            self.myFullPostView.postView.button.tag += 1
            let buttonTag = self.myFullPostView.postView.button.tag
            self.threadsId[buttonTag] = safeThread.id
        }
        
        myFullPostView.postView.button.addTarget(self, action: #selector(deleteThreadAlert(_:)), for: .touchUpInside)
        
        let fullDate = safeThread.createdAt.prefix(10)
        let day = fullDate.suffix(2)
        let month = fullDate.suffix(5).prefix(2)
        let year = fullDate.prefix(4)
        
        //breadcrumbs da pagina
        myFullPostView.currentPageLbl.text = "\(subjectName) > \(safeThread.title)"

        myFullPostView.postView.authorTextView.text =  "\(safeThread.user.firstName) \(safeThread.user.lastName) em \(day)-\(month)-\(year)"

        myFullPostView.postView.titleTextView.text = safeThread.title
        myFullPostView.postView.commentsTextView.text = "\(safeThread.commentCount) comentários"
        myFullPostView.postView.messageTextView.text = safeThread.content
        
    }
    
    @IBAction func deleteThreadAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Deletar postagem", message: "Após concluída, esta ação não pode ser desfeita", preferredStyle: UIAlertController.Style.alert)
        
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


