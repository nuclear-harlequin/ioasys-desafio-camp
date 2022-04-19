//
//  TopicMainPageViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class TopicMainPageViewController: UIViewController{
    lazy var myTopicMainPageView = TopicMainPageView()
    var subjectID: String
    var allSubjects: [Subject]?
    var name: String
    var page = 1
    let network = NetworkService.shared
    var threads: SubjectIDResponse?
    var subjectImageURL: String
    
    init(subjectID: String, name: String, subjectImageURL: String){
        self.subjectID = subjectID
        self.name = name
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

    override func loadView() {
        super.loadView()
        
        self.view = myTopicMainPageView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        
        myTopicMainPageView.topicLabel.text = name
        myTopicMainPageView.breadcrumbs.text = "Home > \(name)"

        
        
        for view in myTopicMainPageView.publicationsStackView.arrangedSubviews{
             view.removeFromSuperview()
         }
        
        myTopicMainPageView.showMoreButton.longButton.addTarget(self, action: #selector(loadMoreThreads(_:)), for: .touchUpInside)
        
        configuresubjectIDImage()
        fetchSubjectIDContent()
        fetchSubjects()
    }
    
    func configuresubjectIDImage(){
        if let myURL = URL(string: subjectImageURL){
            myTopicMainPageView.topicImageCard.imageView.load(url: myURL)
         } else {
             if let myURL = URL(string: "https://bitsofco.de/content/images/2018/12/broken-1.png"){
                 myTopicMainPageView.topicImageCard.imageView.load(url: myURL)
             }
         }
    }
    
    func fetchSubjectIDContent() {
        let parameters = ["order": "ASC", "page": String(page), "take": "10"]

        network.makeUrlRequest(endpoint: .fetchSubjectsID(subjectID: subjectID), path: nil, method: .get, header: nil, body: nil, parameters: parameters) { (result: Result<SubjectIDResponse, RequestError>) in
            switch result {
            case .success(let successValue):
                self.threads = successValue
                DispatchQueue.main.async {
                    self.configureThreadsViews()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureThreadsViews(){
        guard let safeMeta = self.threads?.meta else {
            return
        }
        
        //if there is no nextpage, deletes "load more" button from screen
        if safeMeta.hasNextPage == false {
            myTopicMainPageView.showMoreButton.longButton.removeTarget(self, action: #selector(loadMoreThreads(_:)), for: .touchUpInside)
            myTopicMainPageView.showMoreButton.longButton.isEnabled = false
            myTopicMainPageView.showMoreButton.longButton.layer.opacity = 0.5
        }
        
        guard let safeThreads = self.threads?.data else {
            return
        }
        
        for currentThread in 0..<safeThreads.count{
            let thread = PostThreeLines()
            
            thread.postInfoLabel.text = "\(safeThreads[currentThread].user.firstName) \(safeThreads[currentThread].user.lastName) em \(safeThreads[currentThread].createdAt)"
            thread.postTitleLabel.text = safeThreads[currentThread].title
            thread.postContentLabel.text = safeThreads[currentThread].content
            thread.commentsLabel.text = "\(safeThreads[currentThread].commentCount) Comentários"
            
            thread.addTapGesture {
                self.openThread(id: safeThreads[currentThread].id)
            }
            myTopicMainPageView.publicationsStackView.addArrangedSubview(thread)
        }
    }
    
    func openThread(id: String) {
            print("touched thread \(id)")
            let page = FullPostViewController(threadID: id, subjectName: name, subjectID: subjectID, subjectImageURL: subjectImageURL)
    
          //  present(page, animated: true, completion: nil)
            
          self.navigationController?.setViewControllers([page], animated: true)
    }
    
    @IBAction func loadMoreThreads(_ sender: UIButton) {
        page += 1
        fetchSubjectIDContent()
        print(page)
    }

// bottom of page subjects
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
        
        for view in myTopicMainPageView.topicsScrollStackView.arrangedSubviews{
             view.removeFromSuperview()
         }

         for currentSubject in 0..<safeSubjects.count{
             if safeSubjects[currentSubject].name != name {
                 let subject = TopicCardSmall()
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
                     guard let topicImage = safeSubjects[currentSubject].picture else{
                         return
                     }
                     self.openSubjectPage(of: safeSubjects[currentSubject].id, name: safeSubjects[currentSubject].name, subjectImageURL: topicImage.url )
                     }
                 
                 myTopicMainPageView.topicsScrollStackView.addArrangedSubview(subject)
             }
         }
    }
    
    func openSubjectPage(of subjectID: String, name: String, subjectImageURL:String) {
            print("typed subject \(subjectID)")
        let page = TopicMainPageViewController(subjectID: subjectID, name: name, subjectImageURL: subjectImageURL)
    
          //  present(page, animated: true, completion: nil)
            
          self.navigationController?.setViewControllers([page], animated: true)
    }
}

