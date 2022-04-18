//
//  MakeCommentView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class MakeCommentView: UIView {
    
    lazy var header = Header()
    
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
    
    
    lazy var post = PostView()
    lazy var comment = MessageField()
    lazy var notificationToggle = ActivateNotificationStack()
    lazy var sendCancelButtons = ButtonsStack()
    
    lazy var commentLabel: UILabel = {
        let lbl = UILabel()
        let text = "Escreva seu comentário abaixo:"
        lbl.formatText(font: "Raleway-Bold", fontSize: 16, color: "neutral600")
        lbl.text = text
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //scrollView
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //contentView
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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

extension MakeCommentView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(header)
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentPageLbl)
        contentView.addSubview(post)
        contentView.addSubview(commentLabel)
        contentView.addSubview(comment)
        contentView.addSubview(notificationToggle)
        contentView.addSubview(sendCancelButtons)
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
                    right: contentView.rightAnchor,
                    topConstant: 16.45,
                    leftConstant: 24,
                    rightConstant: 24)
        
        commentLabel.anchor(top: post.bottomAnchor,
                            left: contentView.leftAnchor,
                            right: contentView.rightAnchor,
                            topConstant: 16,
                            leftConstant: 24,
                            rightConstant: 24)
        
        comment.anchor(top: commentLabel.bottomAnchor,
                       left: contentView.leftAnchor,
                       right: contentView.rightAnchor,
                       leftConstant: 25,
                       bottomConstant: 8,
                       rightConstant: 24,
                       heightConstant: 264)
        
        notificationToggle.anchor(top: comment.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24.5,
                                  leftConstant: 24,
                                  rightConstant: 24)
        
        sendCancelButtons.anchor(top: notificationToggle.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 topConstant: 24.5,
                                 leftConstant: 24,
                                 rightConstant: 24)
        
        contentView.anchor(bottom: sendCancelButtons.bottomAnchor,
                           bottomConstant: -40)
    }
    
    func setupAdditionalConfiguration() {
        commentLabel.numberOfLines = 1
    }
}
