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
    var page = 1
    
    let network = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func loadView() {
        super.loadView()
        
        self.view = myMainPageView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        fetchSubjects()
        fetchRecentThreads()
        myMainPageView.showMoreButton.longButton.addTarget(self, action: #selector(loadMoreThreads(_:)), for: .touchUpInside)
        
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
                     self.openSubjectPage(of: safeSubjects[currentSubject].id)
                     }
                 
                 myMainPageView.topicsScrollStackView.addArrangedSubview(subject)
             }
             else if safeSubjects[currentSubject].name == "Aluguel, compra e venda" {
                 myMainPageView.longCard.topicNameLabel.text = safeSubjects[currentSubject].name
                 myMainPageView.longCard.commentNumberLabel.text = String(safeSubjects[currentSubject].threadCount)
                 
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
                     self.openSubjectPage(of: safeSubjects[currentSubject].id)
                     }
                 
             }
         }
    }
    
    func openSubjectPage(of subjectID: String) {
            print("typed subject \(subjectID)")
            let page = TopicMainPageViewController(subjectID: subjectID)
    
          //  present(page, animated: true, completion: nil)
            
          self.navigationController?.setViewControllers([page], animated: true)
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
             
             recentThread.topicLabel.text = safeRecentThreads[currentRecentThread].subject
             recentThread.postInfoLabel.text = "\(safeRecentThreads[currentRecentThread].user.firstName) \(safeRecentThreads[currentRecentThread].user.lastName) em \(safeRecentThreads[currentRecentThread].createdAt)"
             recentThread.postTitleLabel.text = safeRecentThreads[currentRecentThread].title
             recentThread.postContentLabel.text = safeRecentThreads[currentRecentThread].content

             recentThread.addTapGesture {
                     self.openRecentThread(id: "1")
                     }
                 
                 myMainPageView.publicationsStackView.addArrangedSubview(recentThread)
             
         }
    }
    
    func openRecentThread(id: String) {
            print("touched thread \(id)")
            let page = FullPostViewController(threadID: id)
    
          //  present(page, animated: true, completion: nil)
            
          self.navigationController?.setViewControllers([page], animated: true)
    }
    
    @IBAction func loadMoreThreads(_ sender: UIButton) {
        page += 1
        fetchRecentThreads()
        print(page)
    }

}
    


