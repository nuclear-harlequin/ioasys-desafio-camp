//
//  FullPostView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 07/04/22.
//

import Foundation
import UIKit

class FullPostView: UIView{
    lazy var header = Header()

    //currentPageLbl
    lazy var currentPageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Administração > Título do Tópico"
        lbl.textColor = UIColor(red: 0.05, green: 0.29, blue: 0.31, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    //postView
    lazy var postView = FullPost()
    
    //showCommentsButton
    lazy var showCommentsButton = LongButton()
    
    //buttonsStack
    lazy var buttonsStack: ButtonsStack = {
        let buttonsStack = ButtonsStack()
        buttonsStack.postButton.setTitle("COMENTAR", for: .normal)
        buttonsStack.cancelButton.setTitle("VOLTAR", for: .normal)
        return buttonsStack
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
        
        setSubviews()
        setConstraints()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup of the subviews
    func setSubviews(){
        self.addSubview(header)
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentPageLbl)
        contentView.addSubview(postView)
        contentView.addSubview(showCommentsButton)
        contentView.addSubview(buttonsStack)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
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
        
        postView.anchor(top: currentPageLbl.bottomAnchor,
                        left: contentView.leftAnchor,
                        bottom: showCommentsButton.topAnchor,
                        right: contentView.rightAnchor,
                        topConstant: 16.5,
                        leftConstant: 26,
                        bottomConstant: 24,
                        rightConstant: 26)
        
        showCommentsButton.anchor(top: postView.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  topConstant: 24,
                                  leftConstant: 25,
                                  rightConstant: 25,
                                  heightConstant: 55)
        
        buttonsStack.anchor(top: showCommentsButton.bottomAnchor,
                            left: contentView.leftAnchor,
                            right: contentView.rightAnchor,
                            topConstant: 24,
                            leftConstant: 26,
                            rightConstant: 26,
                            heightConstant: 55)
        
        contentView.anchor(bottom: buttonsStack.bottomAnchor,
                           bottomConstant: -32)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

