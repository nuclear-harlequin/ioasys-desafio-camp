//
//  CommentsTableViewController.swift
//  tamojunto
//
//  Created by Giovanna Toni on 11/04/22.
//

import UIKit

class CommentsTableViewController: UIViewController {
    
    private var tableView = UITableView()
    private var fakeComments: [CommentView] = [CommentView]()
    
    private var comment1 = CommentView()
    private var comment2 = CommentView()
    private var comment3 = CommentView()
    private var comment4 = CommentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        populateComments()

        tableView.register(CommentView.self, forCellReuseIdentifier: "commentCell")
    }
    
    func populateComments() {
        fakeComments.append(comment1)
        fakeComments.append(comment2)
        fakeComments.append(comment3)
        fakeComments.append(comment4)
    }
}

extension CommentsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentView
        return cell
    }
}
