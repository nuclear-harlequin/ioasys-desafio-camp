//
//  PostEditorView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 05/04/22.
//


import Foundation
import UIKit

class PostEditorView: UIView{
    lazy var header = Header()

    //currentPageLbl
    lazy var currentPageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Novo Tópico"
        lbl.textColor = UIColor(red: 0.05, green: 0.29, blue: 0.31, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .center
        return lbl
    }()

    //titleLbl
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Escolha um título:"
        lbl.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var titleTextField = TitleField()
    
    //messageLbl
    lazy var messageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Escreva sua mensagem:"
        lbl.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var messageTextField = MessageField()
    
    //themeLbl
    lazy var themeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Escolha o tema da sua publicação:"
        lbl.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    //themeMenu
    lazy var themeMenuButton: UIButton = {
        let btn = UIButton()
        let usersItem = UIAction(title: "Users", image: UIImage(systemName: "person.fill")) { (action) in

              print("Users action was tapped")
         }

         let addUserItem = UIAction(title: "Add User", image: UIImage(systemName: "person.badge.plus")) { (action) in

             print("Add User action was tapped")
         }

         let removeUserItem = UIAction(title: "Remove User", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
              print("Remove User action was tapped")
         }

         let menu = UIMenu(title: "My Menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])
        
        btn.menu = menu
        btn.showsMenuAsPrimaryAction = true
        btn.setTitle("Administração", for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.setTitleColor(UIColor(red: 0.329, green: 0.31, blue: 0.275, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
        btn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 0.718, green: 0.714, blue: 0.678, alpha: 1).cgColor
        return btn
    }()
    
    lazy var buttonsStack = ButtonsStack()
    
    lazy var notificationStack = ActivateNotificationStack()
    
    //contentView
    lazy var contentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //scrollView
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
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
        contentView.addSubview(titleLbl)
        contentView.addSubview(titleTextField)
        contentView.addSubview(messageLbl)
        contentView.addSubview(messageTextField)
        contentView.addSubview(themeLbl)
        contentView.addSubview(themeMenuButton)
        contentView.addSubview(notificationStack)
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
                        leftConstant: 25,
                        heightConstant: 23)
        
        titleLbl.anchor(top: currentPageLbl.bottomAnchor,
                        left: contentView.leftAnchor,
                        topConstant: 16.5,
                        leftConstant: 25,
                        heightConstant: 23)


        titleTextField.anchor(top: titleLbl.bottomAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  topConstant: 8,
                                  leftConstant: 25,
                                  rightConstant: 24,
                                  heightConstant: 55)

        messageLbl.anchor(top: titleTextField.bottomAnchor,
                          left: contentView.leftAnchor,
                         topConstant: 16,
                          leftConstant: 25,
                          heightConstant: 23)

        messageTextField.anchor(top: messageLbl.bottomAnchor,
                                    left: leftAnchor,
                                    right: rightAnchor,
                                    topConstant: 8,
                                    leftConstant: 25,
                                    rightConstant: 24,
                                    heightConstant: 264)

        themeLbl.anchor(top: messageTextField.bottomAnchor,
                        left: contentView.leftAnchor,
                       topConstant: 31,
                        leftConstant: 25,
                        heightConstant: 23)

        themeMenuButton.anchor(top: themeLbl.bottomAnchor,
                               left: leftAnchor,
                               right: rightAnchor,
                               topConstant: 12,
                               leftConstant: 25,
                               rightConstant: 24,
                               heightConstant: 55)

        notificationStack.anchor(top: themeMenuButton.bottomAnchor,
                                     left: contentView.leftAnchor,
                                     right: contentView.rightAnchor,
                                     topConstant: 19.5,
                                     leftConstant: 25,
                                     rightConstant: 24,
                                     heightConstant: 24)

        buttonsStack.anchor(top: notificationStack.bottomAnchor,
                                left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor,
                                right: rightAnchor,
                                topConstant: 17.5,
                                leftConstant: 25,
                                rightConstant: 24)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

