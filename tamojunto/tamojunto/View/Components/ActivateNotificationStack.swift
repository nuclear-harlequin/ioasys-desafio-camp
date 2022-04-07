//
//  ActivateNotificationStack.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class ActivateNotificationStack: UIView{

    //notificationLbl
    lazy var notificationLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ativar notificações de comentários"
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Regular", size: 16)
        lbl.textAlignment = .justified
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //notificationSwitch
    lazy var notificationSwitch: UISwitch = {
        let swtch = UISwitch()
        swtch.isOn = false
        swtch.isEnabled = false
        swtch.translatesAutoresizingMaskIntoConstraints = false
        return swtch
    }()
    
    //stack horizontal para notificações
    lazy var notificationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
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
        self.addSubview(notificationStackView)
        notificationStackView.addArrangedSubview(notificationLbl)
        notificationStackView.addArrangedSubview(notificationSwitch)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        notificationStackView.anchor(top: topAnchor,
                                     left: leftAnchor,
                                     bottom: bottomAnchor,
                                     right: rightAnchor)

        notificationLbl.anchor(left: notificationStackView.leftAnchor,
                               heightConstant: 24)

        notificationSwitch.anchor(right: notificationStackView.rightAnchor,
                                  heightConstant: 24)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

