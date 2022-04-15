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
    
    let network = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func loadView() {
        super.loadView()
        
        self.view = myMainPageView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
//        fetchSubjects()
        fetchRecentThreads()
    }
}

extension MainPageViewController {
    func fetchSubjects() {
        network.makeUrlRequest(endpoint: .fetchSubjects, path: nil, method: .get, header: nil, body: nil, parameters: nil) { (result: Result<[Subject], RequestError>) in
            switch result {
            case .success(let fetchedSubjects):
//                print(fetchedSubjects)
                self.allSubjects = fetchedSubjects
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRecentThreads() {
        let parameters = ["order": "ASC", "page": "1", "take": "10"]
        
        network.makeUrlRequest(endpoint: .fetchThreads, path: nil, method: .get, header: nil, body: nil, parameters: parameters) { (result: Result<ThreadResponse, RequestError>) in
            switch result {
            case .success(let fetchedThreads):
                print(fetchedThreads)
//                self.recentThreads = fetchedThreads
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func fetchSubjectContent() {
//        let path =
//
//        let parameters = ["order": "ASC", "page": "1", "take": "10"]
//
//        network.makeUrlRequest(endpoint: .fetchSubjects, path: , method: .get, header: nil, body: nil, parameter: parameters) { (result: Result<[Subject], RequestError>) in
//            switch result {
//            case .success(let successValue):
//                self.subject = successValue
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

//
//  MainPostViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 08/04/22.
//
//
//import Foundation
//import UIKit
//
//class MainPageViewController: UIViewController{
//    lazy var myMainPageView = MainPageView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    override func loadView() {
//        super.loadView()
//
//        self.view = myMainPageView
//        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
//        //loadview
//    }
//
//    func loadMainPage(page: Int, authCode: String, searchTerm: String){
//        MainPageRequest().requestInformation { data, response, error in
//            if let error = error {
//                print(error)
//            } else {
//                guard let response = response as? HTTPURLResponse else {
//                    print("Houve um erro!")
//                    return
//                }
//
//                if response.statusCode >= 200 && response.statusCode <= 299{
//                    do{
//                        let mySubjects = try JSONDecoder().decode(SubjectMainPage.self, from: data!)
//
//                        DispatchQueue.main.async {
//                            //para garantir que o scroll só adicione cada página uma vez, ncessita condição
//                            for view in myMainPageView.topicsScrollStackView.arrangedSubviews{
//                                view.removeFromSuperview()
//                            }
//
//                            for currentSubject in 0..<mySubjects.data.count{
//                                let subject = TopicCardNarrow()
//
//                                subject.commentNumberLabel = mySubjects.data[currentSubject].threadCount
//
//                                subject.topicNameLabel = mySubjects.data[currentSubject].nome
//
//                                let myString = mySubjects.data[currentSubject].picture.url
//                                if myString != nil {
//                                    if let myURL = URL(string: myString!){
//                                        subject.imageView.load(url: myURL)
//                                    }
//                                } else {
//                                    if let myURL = URL(string: "https://bitsofco.de/content/images/2018/12/broken-1.png"){
//                                        subject.imageView.load(url: myURL)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                    catch{
//                        print(error)
//                    }
//                }
//            }
//        }
//    }
//}

