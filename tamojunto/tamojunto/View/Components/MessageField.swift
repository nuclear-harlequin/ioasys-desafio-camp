//
//  MessageField.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class MessageField: UIView{
    //messageTextField
    lazy var messageTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textField.font = UIFont(name: "Raleway-Regular", size: 16)
        textField.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        textField.text = "Seu texto aqui..."
        textField.autocapitalizationType = .none
        textField.isEditable = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    //messageTextFieldView
    lazy var messageTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.718, green: 0.714, blue: 0.678, alpha: 1).cgColor
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
        self.addSubview(messageTextFieldView)
        messageTextFieldView.addSubview(messageTextField)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        messageTextFieldView.anchor(top: topAnchor,
                                     left: leftAnchor,
                                     bottom: bottomAnchor,
                                     right: rightAnchor)
                
        messageTextField.anchor(top: messageTextFieldView.topAnchor,
                               left: messageTextFieldView.leftAnchor,
                               bottom: messageTextFieldView.bottomAnchor,
                               right: messageTextFieldView.rightAnchor,
                               topConstant: 16,
                               leftConstant: 24,
                               bottomConstant:16,
                               rightConstant: 24)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }    
}

