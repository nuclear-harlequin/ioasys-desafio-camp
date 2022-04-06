//
//  ButtonsStack.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class ButtonsStack: UIView{

    //cancelButton
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("CANCELAR", for: .normal)
        btn.setTitleColor(UIColor(red: 0.008, green: 0.071, blue: 0.059, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 16)
        btn.layer.backgroundColor = UIColor(named: "secondary70")?.cgColor
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    //postButton
    lazy var postButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("PUBLICAR", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 16)
        btn.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    //stack horizontal para botões
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        self.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(postButton)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        buttonsStackView.anchor(top: topAnchor,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                right: rightAnchor)

        cancelButton.anchor(left: buttonsStackView.leftAnchor,
                            heightConstant: 55)

        postButton.anchor(right: buttonsStackView.rightAnchor,
                          heightConstant: 55)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

