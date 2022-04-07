//
//  LongButton.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 07/04/22.
//

import Foundation
import UIKit

class LongButton: UIView{
    //longButton
    lazy var longButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("EXIBIR COMENTÁRIOS", for: .normal)
        btn.setTitleColor(UIColor(named: "primary500"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 16)
        btn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(named: "primary500")?.cgColor
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
        self.addSubview(longButton)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
                
        longButton.anchor(top: topAnchor,
                                  left: leftAnchor,
                                  bottom: bottomAnchor,
                                  right: rightAnchor,
                                  heightConstant: 55)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

