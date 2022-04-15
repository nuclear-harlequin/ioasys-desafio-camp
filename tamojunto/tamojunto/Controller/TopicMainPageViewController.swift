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
    
    init(subjectID: String){
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
        
        self.view = myTopicMainPageView
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
    }
//    
//    func fetchSubjectContent() {
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

