//
//  CommentsInPostView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 08/04/22.
//

import UIKit

class CommentsInPostView: UIView {
    
    lazy var commentsTable = UITableView()
    lazy var post = PostView()
    lazy var notificationToggle = ActivateNotificationStack()
    lazy var moreCommentsButton = LongButton()
    lazy var commentBackButtons = ButtonsStack()
    
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
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
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
        contentView.addSubview(commentsTable)
        contentView.addSubview(post)
        contentView.addSubview(notificationToggle)
        contentView.addSubview(moreCommentsButton)
        contentView.addSubview(commentBackButtons)
        contentView.addSubview(numberOfCommentsLabel)
    }
    
    func setupConstraints() {
        scrollView.anchorTo(superview: self)
        contentView.anchorTo(superview: scrollView)
        
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
                                     bottom: commentsTable.topAnchor,
                                     right: contentView.rightAnchor,
                                     topConstant: 16,
                                     leftConstant: 24,
                                     bottomConstant: 16,
                                     rightConstant: 24)
        
        commentsTable.anchor(top: numberOfCommentsLabel.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: notificationToggle.topAnchor,
                             right: contentView.rightAnchor,
                             topConstant: 16,
                             leftConstant: 26,
                             bottomConstant: 24.5,
                             rightConstant: 22)
        
        notificationToggle.anchor(top: commentsTable.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: moreCommentsButton.topAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24.5,
                                  leftConstant: 24,
                                  bottomConstant: 24.5,
                                  rightConstant: 24)
        
        commentBackButtons.anchor(top: notificationToggle.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24.5,
                                  leftConstant: 26,
                                  bottomConstant: 105,
                                  rightConstant: 24)
    }
    
    func setupAdditionalConfiguration() {
        moreCommentsButton.longButton.setTitle("EXIBIR MAIS COMENTÁRIOS", for: .normal)
        commentBackButtons.cancelButton.setTitle("VOLTAR", for: .normal)
        commentBackButtons.postButton.setTitle("COMENTAR", for: .normal)
    }
    
    
}
