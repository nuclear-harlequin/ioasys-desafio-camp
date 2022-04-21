//
//  SearchSuccessViewController.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class SearchSuccessViewController: UIViewController {
    lazy var mySearchResults = SearchSuccessView()
    var searchResults: SearchResponse?
    let network = NetworkService.shared
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.mySearchResults.searchBar.searchTextField.addTarget(self, action: #selector(onReturn), for: UIControl.Event.editingDidEndOnExit)
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
        
        self.view = mySearchResults
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.914, blue: 0.925, alpha: 1)
        
        for view in mySearchResults.resultsStackView.arrangedSubviews{
            view.removeFromSuperview()
        }
        
        mySearchResults.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        mySearchResults.showMoreButton.longButton.addTarget(self, action: #selector(loadMoreResults(_:)), for: .touchUpInside)
        //send to main page
        mySearchResults.header.labelStackView.addTapGesture {
            let page = MainPageViewController()
            self.navigationController?.setViewControllers([page], animated: true)
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onReturn() {
        self.mySearchResults.searchBar.searchTextField.resignFirstResponder()
        
        makeSearch()
    }
    
    @IBAction func loadMoreResults(_ sender: UIButton) {
        page += 1
        makeSearch()
        print(page)
    }

    func configureThreadViews(){
        self.mySearchResults.resultsLabel.text = "Resultados da sua busca:"
        self.mySearchResults.showMoreButton.isHidden = false
        
        for view in mySearchResults.resultsStackView.arrangedSubviews{
            view.removeFromSuperview()
        }
        
        guard let searchResultsMeta = self.searchResults?.meta else { return }
        
        //if there is no nextpage, deletes "load more" button from screen
        if !searchResultsMeta.hasNextPage {
            mySearchResults.showMoreButton.longButton.removeTarget(self, action: #selector(loadMoreResults(_:)), for: .touchUpInside)
            mySearchResults.showMoreButton.longButton.isEnabled = false
            mySearchResults.showMoreButton.longButton.layer.opacity = 0.5
        }
        
        guard let searchResults = self.searchResults?.data else { return }
        
        for currentThread in 0..<searchResults.count {
            let thread = PostTwoLines()
            let fullDate = searchResults[currentThread].createdAt.prefix(10)
            let day = fullDate.suffix(2)
            let month = fullDate.suffix(5).prefix(2)
            let year = fullDate.prefix(4)
            
            thread.button.isHidden = true
            
            thread.topicLabel.text = searchResults[currentThread].subject
            thread.postInfoLabel.text = "Criado em \(day)-\(month)-\(year)"
            thread.postTitleLabel.text = searchResults[currentThread].title
            thread.postContentLabel.text = searchResults[currentThread].content
            
            let subjectId = Dictionaries().subjectsDict[searchResults[currentThread].subject]
            
            guard let subjectId = subjectId
            else {
                print("Error finding subject id")
                return
            }
            
            let subjectImageURL = Dictionaries().pictureURLDict[subjectId]
            
            guard let subjectImageURL = subjectImageURL
            else {
                print("Error finding subject image")
                return
            }
            
            thread.addTapGesture {
                self.openThread(id: searchResults[currentThread].id, subjectName: searchResults[currentThread].subject, subjectID: subjectId, subjectImageURL: subjectImageURL)
            }
            mySearchResults.resultsStackView.addArrangedSubview(thread)
        }
    }
    
    func openThread(id: String, subjectName: String, subjectID: String, subjectImageURL: String) {
        let page = FullPostViewController(threadID: id, subjectName: subjectName, subjectID: subjectID, subjectImageURL: subjectImageURL)
        self.navigationController?.pushViewController(page, animated: true)
    }

    func makeSearch() {
        let searchTerm = self.mySearchResults.searchBar.searchTextField.text ?? ""
        
        let parameters = ["query": searchTerm, "order": "ASC", "page": String(self.page), "take": "10"]
        
        network.makeUrlRequest(endpoint: .makeSearch, path: nil, method: .post, header: nil, body: nil, parameters: parameters) { (result: Result<SearchResponse, RequestError>) in
            switch result {
            case .success(let searchResults):
                self.searchResults = searchResults
                
                let foundThreads = self.searchResults?.data
                
                guard let foundThreads = foundThreads
                else {
                    print("There was an error fetching the results")
                    return
                }
                
                if foundThreads.isEmpty {
                    DispatchQueue.main.async {
                        for view in self.mySearchResults.resultsStackView.arrangedSubviews{
                            view.removeFromSuperview()
                        }
                        
                        self.mySearchResults.showMoreButton.isHidden = true
                        
                        self.mySearchResults.resultsLabel.text =
                        """
                        Sentimos muito!\n
                        Infelizmente não encontramos resultados para “Palavra-chave buscada”.\n
                        Verifique a ortografia ou busque por termos relacionados.
                        """
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.configureThreadViews()
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
