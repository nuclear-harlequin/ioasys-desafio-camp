//
//  MainPostViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 08/04/22.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {
    lazy var myMainPageView = MainPageView()
    
    var allSubjects: [Subject]?
    var recentThreads: ThreadResponse?
    var subjectsDict = Dictionaries().subjectsDict
    var threadsId: [Int:String] = [:]
    
    var page = 1
    
    let network = NetworkService.shared
 
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
        
        self.view = myMainPageView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        fetchSubjects()
        fetchRecentThreads()
        myMainPageView.showMoreButton.longButton.addTarget(self, action: #selector(loadMoreThreads(_:)), for: .touchUpInside)
        myMainPageView.searchBarButton.addTapGesture {self.goToSearchPage()}
        
        for view in myMainPageView.publicationsStackView.arrangedSubviews{
            view.removeFromSuperview()
        }

    }
    
    func fetchSubjects() {
        network.makeUrlRequest(endpoint: .fetchSubjects, path: nil, method: .get, header: nil, body: nil, parameters: nil) { (result: Result<[Subject], RequestError>) in
            switch result {
            case .success(let fetchedSubjects):
                self.allSubjects = fetchedSubjects
                DispatchQueue.main.async {
                    self.configureSubjectViews()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureSubjectViews(){
        guard let safeSubjects = self.allSubjects else {
            return
        }
        
        for view in myMainPageView.topicsScrollStackView.arrangedSubviews{
            view.removeFromSuperview()
        }
        
        for currentSubject in 0..<safeSubjects.count{
            if safeSubjects[currentSubject].name != "Aluguel, compra e venda"{
                let subject = TopicCardNarrow()
                subject.commentNumberLabel.text = String(safeSubjects[currentSubject].threadCount)
                subject.topicNumberLabel.text = "\(safeSubjects[currentSubject].threadCount) tópicos"
                subject.topicNameLabel.text = safeSubjects[currentSubject].name
                
                guard let myString = safeSubjects[currentSubject].picture?.url else {
                    return
                }
                
                if let myURL = URL(string: myString){
                    subject.imageView.load(url: myURL)
                } else {
                    if let myURL = URL(string: "https://bitsofco.de/content/images/2018/12/broken-1.png"){
                        subject.imageView.load(url: myURL)
                    }
                }
                
                subject.addTapGesture {
                    self.openSubjectPage(of: safeSubjects[currentSubject].id, name: safeSubjects[currentSubject].name, subjectImageURL: safeSubjects[currentSubject].picture?.url)
                }
                
                myMainPageView.topicsScrollStackView.addArrangedSubview(subject)
            }
            else if safeSubjects[currentSubject].name == "Aluguel, compra e venda" {
                myMainPageView.longCard.topicNameLabel.text = safeSubjects[currentSubject].name
                myMainPageView.longCard.commentNumberLabel.text = String(safeSubjects[currentSubject].threadCount)
                myMainPageView.longCard.topicNumberLabel.text = "\(safeSubjects[currentSubject].threadCount) tópicos"
                
                guard let myString = safeSubjects[currentSubject].picture?.url else {
                    return
                }
                
                if let myURL = URL(string: myString){
                    myMainPageView.longCard.imageView.load(url: myURL)
                } else {
                    if let myURL = URL(string: "https://bitsofco.de/content/images/2018/12/broken-1.png"){
                        myMainPageView.longCard.imageView.load(url: myURL)
                    }
                }
                myMainPageView.longCard.addTapGesture {
                    self.openSubjectPage(of: safeSubjects[currentSubject].id, name: safeSubjects[currentSubject].name, subjectImageURL: safeSubjects[currentSubject].picture?.url)
                }
            }
        }
    }
    
    func openSubjectPage(of subjectID: String, name: String, subjectImageURL: String?) {
        print("typed subject \(subjectID)")
        guard let subjectImageURL = subjectImageURL else {
            return
        }
        
        let page = TopicMainPageViewController(subjectID: subjectID, name: name, subjectImageURL: subjectImageURL)
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    func fetchRecentThreads() {
        let parameters = ["order": "ASC", "page": String(page), "take": "10"]
        
        network.makeUrlRequest(endpoint: .fetchThreads, path: nil, method: .get, header: nil, body: nil, parameters: parameters) { (result: Result<ThreadResponse, RequestError>) in
            switch result {
            case .success(let fetchedThreads):
                self.recentThreads = fetchedThreads
                DispatchQueue.main.async {
                    self.configureRecentThreadsViews()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureRecentThreadsViews(){
        guard let safeRecentThreads = self.recentThreads?.data else {
            return
        }
        
        for currentRecentThread in 0..<safeRecentThreads.count{
            let recentThread = PostTwoLines()
            let fullDate = safeRecentThreads[currentRecentThread].createdAt.prefix(10)
            let day = fullDate.suffix(2)
            let month = fullDate.suffix(5).prefix(2)
            let year = fullDate.prefix(4)
            
            let user = UserID()
            let userId = user.userID
            
            print(userId)
            print(safeRecentThreads[currentRecentThread].user.id)
            
            if userId != safeRecentThreads[currentRecentThread].user.id {
                recentThread.button.isHidden = true
            } else {
                recentThread.button.tag += 1
                let buttonTag = recentThread.button.tag
                self.threadsId[buttonTag] = safeRecentThreads[currentRecentThread].id
            }
            
            recentThread.button.addTarget(self, action: #selector(deleteThreadAlert(_:)), for: .touchUpInside)
            
            recentThread.topicLabel.text = safeRecentThreads[currentRecentThread].subject
            recentThread.postInfoLabel.text = "\(safeRecentThreads[currentRecentThread].user.firstName) \(safeRecentThreads[currentRecentThread].user.lastName) em \(day)-\(month)-\(year)"
            recentThread.postTitleLabel.text = safeRecentThreads[currentRecentThread].title
            recentThread.postContentLabel.text = safeRecentThreads[currentRecentThread].content
            
            recentThread.addTapGesture {
                guard let safeSubjects = self.allSubjects else {
                    return
                }
                
                var subjectImageURL = ""
                for subject in 0..<safeSubjects.count{
                    if safeSubjects[subject].name == safeRecentThreads[currentRecentThread].subject {
                        guard let  subjectImage = safeSubjects[subject].picture else {
                            return
                        }
                        subjectImageURL = subjectImage.url
                    }
                }
                self.openRecentThread(id: safeRecentThreads[currentRecentThread].id, subjectName: safeRecentThreads[currentRecentThread].subject, subjectID: self.subjectsDict[safeRecentThreads[currentRecentThread].subject] ?? "32dd929b-d4e9-460a-9a12-c4dc0ade5daf", subjectImageURL: subjectImageURL )
            }
            
            myMainPageView.publicationsStackView.addArrangedSubview(recentThread)
            
        }
    }
    
    func openRecentThread(id: String, subjectName: String, subjectID: String, subjectImageURL: String) {
        print("touched thread \(id)")
        
        let page = FullPostViewController(threadID: id, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func loadMoreThreads(_ sender: UIButton) {
        page += 1
        fetchRecentThreads()
        print(page)
    }
    
    func goToSearchPage() {
        print("Clicou")
        let page = SearchSuccessViewController()
        self.navigationController?.pushViewController(page, animated: true)
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
