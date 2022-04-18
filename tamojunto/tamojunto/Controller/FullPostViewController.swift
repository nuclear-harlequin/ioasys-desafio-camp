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
    
    init(threadID: String, subjectName: String, subjectID: String){
        self.threadID = threadID
        self.subjectName = subjectName
        self.subjectID = subjectID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func loadView() {
        super.loadView()
        
        self.view = myFullPostView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        loadThread()
        
        myFullPostView.buttonsStack.cancelButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        myFullPostView.buttonsStack.postButton.addTarget(self, action: #selector(postComment(_:)), for: .touchUpInside)
        myFullPostView.showCommentsButton.longButton.addTarget(self, action: #selector(showComments(_:)), for: .touchUpInside)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        let page = TopicMainPageViewController(subjectID: subjectID, name: subjectName)
        self.navigationController?.setViewControllers([page], animated: true)
        print("goingback")
    }
    
    @IBAction func postComment(_ sender: UIButton) {
        guard let thread = thread else {
            return
        }

        let page = MakeCommentViewController(thread: thread, subjectName: subjectName, subjectID: subjectID)
        self.navigationController?.setViewControllers([page], animated: true)
        print("postComment")
    }
    
    @IBAction func showComments(_ sender: UIButton) {
        guard let thread = thread else {
            return
        }

        let page = PostCommentsViewController(thread: thread, subjectName: subjectName, subjectID: subjectID)
        self.navigationController?.setViewControllers([page], animated: true)
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
        //breadcrumbs da pagina
        myFullPostView.currentPageLbl.text = "\(subjectName) > \(safeThread.title)"

        myFullPostView.postView.authorTextView.text =  "\(safeThread.user.firstName) \(safeThread.user.lastName) em \(safeThread.createdAt)"
         
        myFullPostView.postView.titleTextView.text = safeThread.title
        myFullPostView.postView.commentsTextView.text = "\(safeThread.commentCount) comentários"
        myFullPostView.postView.messageTextView.text = safeThread.content
    }
}


