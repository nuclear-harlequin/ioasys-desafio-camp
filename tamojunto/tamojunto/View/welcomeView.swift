//
//  welcomeView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 19/04/22.
//

import Foundation
import UIKit

class welcomeView: UIView{
    //brackgroundImage
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "launchBackground")
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //logoImage
    lazy var logoImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.image = UIImage(named: "logo")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //loginButton
    lazy var loginButton: LongButton = {
        let btn = LongButton()
        btn.longButton.setTitle("Entrar", for: .normal)
        btn.longButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.longButton.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 20)
        btn.longButton.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
        return btn
    }()
    
    //signupButton
    lazy var signupButton: LongButton = {
        let btn = LongButton()
        btn.longButton.setTitle("Criar uma conta no site", for: .normal)
        btn.longButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.longButton.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 20)
        btn.longButton.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
        return btn
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
        self.addSubview(backgroundImage)
        self.addSubview(logoImage)
        self.addSubview(loginButton)
        self.addSubview(signupButton)
        
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        backgroundImage.anchor(top: topAnchor,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                right: rightAnchor)
        
        logoImage.anchor(top: backgroundImage.topAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                         topConstant: 229,
                         leftConstant: 114,
                         rightConstant: 114)
        
        signupButton.anchor(
                           left: backgroundImage.leftAnchor,
                           bottom: backgroundImage.bottomAnchor,
                           right: backgroundImage.rightAnchor,
                           leftConstant: 24,
                           bottomConstant: 77,
                           rightConstant: 24)
        
        loginButton.anchor(
                            left: backgroundImage.leftAnchor,
                            bottom: signupButton.topAnchor,
                            right: backgroundImage.rightAnchor,
                            leftConstant: 24,
                            bottomConstant: 24,
                            rightConstant: 24)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

