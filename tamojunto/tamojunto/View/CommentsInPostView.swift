//
//  CommentsInPostView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 08/04/22.
//

import UIKit

class CommentsInPostView: UIView {
    
    //currentPageLbl
    lazy var currentPageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Administração > Título do Tópico"
        lbl.textColor = UIColor(red: 0.05, green: 0.29, blue: 0.31, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var header = Header()
    lazy var post = PostView()
    lazy var notificationToggle = ActivateNotificationStack()
    lazy var moreCommentsButton = LongButton()
    lazy var commentBackButtons = ButtonsStack()
    lazy var commentsStack = CommentsStackView()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //contentView
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary20")
        view.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(header)
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentPageLbl)
        contentView.addSubview(post)
        contentView.addSubview(numberOfCommentsLabel)
        contentView.addSubview(commentsStack)
        contentView.addSubview(notificationToggle)
        contentView.addSubview(moreCommentsButton)
        contentView.addSubview(commentBackButtons)
    }
    
    func setupConstraints() {
        header.anchor(top: topAnchor,
                      left: leftAnchor,
                      right: rightAnchor,
                      heightConstant: 80)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
        ])
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
        contentViewHeight.priority = .defaultLow

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
        
        currentPageLbl.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              leftConstant: 24,
                              rightConstant: 24,
                              heightConstant: 23)
        
        post.anchor(top: currentPageLbl.bottomAnchor,
                    left: contentView.leftAnchor,
                    bottom: numberOfCommentsLabel.topAnchor,
                    right: contentView.rightAnchor,
                    topConstant: 16.5,
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
                                  rightConstant: 24,
                                  heightConstant: 55)
        
        contentView.anchor(bottom: commentBackButtons.bottomAnchor,
                           bottomConstant: -32)
    }
    
    func setupAdditionalConfiguration() {
        moreCommentsButton.longButton.setTitle("EXIBIR MAIS COMENTÁRIOS", for: .normal)
        commentBackButtons.cancelButton.setTitle("VOLTAR", for: .normal)
        commentBackButtons.postButton.setTitle("COMENTAR", for: .normal)
    }
    
    
}
