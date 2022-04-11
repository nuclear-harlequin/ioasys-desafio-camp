//
//  CommentsStackView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 11/04/22.
//

import UIKit

class CommentsStackView: UIView {
    
    private var comment1 = CommentView()
    private var comment2 = CommentView()
    private var comment3 = CommentView()
    private var comment4 = CommentView()
    
    lazy var commentsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CommentsStackView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(commentsStack)
        commentsStack.addSubview(comment1)
        commentsStack.addSubview(comment2)
        commentsStack.addSubview(comment3)
        commentsStack.addSubview(comment4)
    }
    
    func setupConstraints() {
        commentsStack.anchorTo(superview: self)
    }
    
    func setupAdditionalConfiguration() {
    }
    
    
}
