//
//  TitleField.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class TitleField: UIView{
    //titleTextField
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Título..."
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "Digite aqui...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)])
        textField.font = UIFont(name: "Raleway-Regular", size: 16)
        textField.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    //titleBarView
    lazy var titleTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.718, green: 0.714, blue: 0.678, alpha: 1).cgColor
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
        self.addSubview(titleTextFieldView)
        titleTextFieldView.addSubview(titleTextField)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        titleTextFieldView.anchorTo(superview: self)
                

        titleTextField.anchor(top: titleTextFieldView.topAnchor,
                              left: titleTextFieldView.leftAnchor,
                              bottom: titleTextFieldView.bottomAnchor,
                              right: titleTextFieldView.rightAnchor,
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

