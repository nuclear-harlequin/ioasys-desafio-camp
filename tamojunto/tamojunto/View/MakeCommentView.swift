//
//  MakeCommentView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class MakeCommentView: UIView {

    lazy var post = PostView()
    lazy var comment = MessageField()
    lazy var notificationToggle = ActivateNotificationStack()
    lazy var sendCancelButtons = ButtonsStack()
    
    lazy var commentLabel: UILabel = {
        let lbl = UILabel()
        let text = "Escreva seu comentário abaixo:"
        lbl.formatText(font: "Raleway-Bold", fontSize: 16, color: "neutral600")
        lbl.text = text
        return lbl
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(named: "primary20")
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
        contentView.addSubview(post)
        contentView.addSubview(commentLabel)
        contentView.addSubview(comment)
        contentView.addSubview(notificationToggle)
        contentView.addSubview(sendCancelButtons)
        self.addSubview(contentView)
    }
    
    func setupConstraints() {
        contentView.anchorTo(superview: self)
        
        post.anchor(top: contentView.topAnchor,
                    left: contentView.leftAnchor,
                    bottom: commentLabel.topAnchor,
                    right: contentView.rightAnchor,
                    topConstant: 139,
                    leftConstant: 24,
                    bottomConstant: 16,
                    rightConstant: 24)
        
        commentLabel.anchor(top: post.bottomAnchor,
                            left: contentView.leftAnchor,
                            bottom: comment.topAnchor,
                            right: contentView.rightAnchor,
                            topConstant: 8,
                            leftConstant: 25,
                            bottomConstant: 8,
                            rightConstant: 124)
        
        comment.anchor(top: commentLabel.bottomAnchor,
                       left: contentView.leftAnchor,
                       bottom: notificationToggle.topAnchor,
                       right: contentView.rightAnchor,
                       leftConstant: 25,
                       bottomConstant: 24.5,
                       rightConstant: 24)
        
        notificationToggle.anchor(top: comment.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: sendCancelButtons.topAnchor,
                                  right: contentView.rightAnchor,
                                  leftConstant: 24,
                                  bottomConstant: 24.5,
                                  rightConstant: 24)
        
        sendCancelButtons.anchor(top: notificationToggle.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 bottom: contentView.bottomAnchor,
                                 right: contentView.rightAnchor,
                                 leftConstant: 24,
                                 bottomConstant: 105,
                                 rightConstant: 26)
    }
    
    func setupAdditionalConfiguration() {
        commentLabel.numberOfLines = 1
    }
}
