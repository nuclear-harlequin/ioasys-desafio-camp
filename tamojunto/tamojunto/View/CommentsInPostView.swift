//
//  CommentsInPostView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 08/04/22.
//

import UIKit

class CommentsInPostView: UIView {
    
    lazy var post = PostView()
    lazy var notificationToggle = ActivateNotificationStack()
    lazy var moreCommentsButton = LongButton()
    lazy var commentBackButtons = ButtonsStack()
    lazy var commentsStack = CommentsStackView()
    
    lazy var scrollView = UIScrollView()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary20")
        return view
    }()
    
    lazy var numberOfCommentsLabel: UILabel = {
        let lbl = UILabel()
        let numberOfComments = "XX"
        let text = "\(numberOfComments) Comentários"
        lbl.formatText(font: "Raleway-Bold", fontSize: 18, color: "primary500")
        lbl.text = text
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentsInPostView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(post)
        contentView.addSubview(numberOfCommentsLabel)
        contentView.addSubview(commentsStack)
        contentView.addSubview(notificationToggle)
        contentView.addSubview(moreCommentsButton)
        contentView.addSubview(commentBackButtons)
    }
    
    func setupConstraints() {
        scrollView.anchorTo(superview: self)
        scrollView.anchorCenterSuperview()
        
        contentView.anchorTo(superview: scrollView)
        contentView.anchorCenterSuperview()
        
        post.anchor(top: contentView.topAnchor,
                    left: contentView.leftAnchor,
                    bottom: numberOfCommentsLabel.topAnchor,
                    right: contentView.rightAnchor,
                    topConstant: 144,
                    leftConstant: 24,
                    bottomConstant: 16,
                    rightConstant: 24)
        
        numberOfCommentsLabel.anchor(top: post.bottomAnchor,
                                     left: contentView.leftAnchor,
                                     bottom: commentsStack.topAnchor,
                                     right: contentView.rightAnchor,
                                     topConstant: 16,
                                     leftConstant: 24,
                                     bottomConstant: 16,
                                     rightConstant: 24)
        
        commentsStack.anchor(top: numberOfCommentsLabel.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: notificationToggle.topAnchor,
                             right: contentView.rightAnchor,
                             topConstant: 16,
                             leftConstant: 24,
                             bottomConstant: 24.5,
                             rightConstant: 24)
        
        notificationToggle.anchor(top: commentsStack.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: moreCommentsButton.topAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24.5,
                                  leftConstant: 24,
                                  bottomConstant: 24.5,
                                  rightConstant: 24)
        
        moreCommentsButton.anchor(top: notificationToggle.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: commentBackButtons.topAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24.5,
                                  leftConstant: 25,
                                  bottomConstant: 24,
                                  rightConstant: 25)
        
        commentBackButtons.anchor(top: moreCommentsButton.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24,
                                  leftConstant: 26,
                                  rightConstant: 24)
    }
    
    func setupAdditionalConfiguration() {
        moreCommentsButton.longButton.setTitle("EXIBIR MAIS COMENTÁRIOS", for: .normal)
        commentBackButtons.cancelButton.setTitle("VOLTAR", for: .normal)
        commentBackButtons.postButton.setTitle("COMENTAR", for: .normal)
    }
    
    
}