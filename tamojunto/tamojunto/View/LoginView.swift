//
//  LoginView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 19/04/22.
//

import Foundation
import UIKit

class loginView: UIView{
    //brackgroundImage
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "loginBackground")
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //logoImage
    lazy var logoImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.image = UIImage(named: "logoShadow")
        img.contentMode = .scaleAspectFill
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Que bom te ver de novo!"
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Regular", size: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email:"
        lbl.textColor = UIColor(named: "neutral600")
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var emailTextField: TitleField = {
        let txtfield = TitleField()
        txtfield.titleTextField.placeholder = "Digite seu email..."
        return txtfield
    }()
    
    lazy var passwordLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Senha:"
        lbl.textColor = UIColor(named: "neutral600")
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var passwordTextField: TitleField = {
        let txtfield = TitleField()
        txtfield.titleTextField.placeholder = "Digite sua senha..."
        return txtfield
    }()
    
    //loginButton
    lazy var loginButton: LongButton = {
        let btn = LongButton()
        btn.longButton.setTitle("ENTRAR", for: .normal)
        btn.longButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.longButton.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 20)
        btn.longButton.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
        return btn
    }()
    
    lazy var signupLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ainda não tem cadastro? Então"
        lbl.textColor = UIColor(named: "primary800")
        lbl.font = UIFont(name: "Raleway-Regular", size: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var signupButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("cadastre-se no nosso site.", for: .normal)
        btn.setTitleColor(UIColor(named: "primary800"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 18)
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
        self.addSubview(welcomeLbl)
        self.addSubview(emailLbl)
        self.addSubview(emailTextField)
        self.addSubview(passwordLbl)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(signupLabel)
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
                         topConstant: 78,
                         leftConstant: 135,
                         rightConstant: 135)
        
        welcomeLbl.anchor(top: logoImage.bottomAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                          topConstant: 19.7,
                         leftConstant: 24,
                         rightConstant: 24)
        
        emailLbl.anchor(top: welcomeLbl.bottomAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                          topConstant: 38,
                         leftConstant: 24,
                         rightConstant: 24)
        
        emailTextField.anchor(top: emailLbl.bottomAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                          topConstant: 8,
                         leftConstant: 24,
                         rightConstant: 24)
        
        passwordLbl.anchor(top: emailTextField.bottomAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                          topConstant: 24,
                         leftConstant: 24,
                         rightConstant: 24)
        
        passwordTextField.anchor(top: passwordLbl.bottomAnchor,
                         left: backgroundImage.leftAnchor,
                         right: backgroundImage.rightAnchor,
                          topConstant: 8,
                         leftConstant: 24,
                         rightConstant: 24)
        
        loginButton.anchor(top: passwordTextField.bottomAnchor,
                            left: backgroundImage.leftAnchor,
                            right: backgroundImage.rightAnchor,
                             topConstant: 32,
                            leftConstant: 24,
                            rightConstant: 24)
        
        signupButton.anchor(
                            left: backgroundImage.leftAnchor,
                            bottom: backgroundImage.bottomAnchor,
                            right: backgroundImage.rightAnchor,
                            leftConstant: 24,
                            bottomConstant: 41,
                            rightConstant: 24)
        
        signupLabel.anchor(
                            left: backgroundImage.leftAnchor,
                            bottom: signupButton.topAnchor,
                            right: backgroundImage.rightAnchor,
                            leftConstant: 24,
                            bottomConstant: 0,
                            rightConstant: 24)
    
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //para dispensar o teclado ao clicar fora do textfield
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
    }
    
    
    
}

