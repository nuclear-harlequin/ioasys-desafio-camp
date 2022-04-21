//
//  Header.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class Header: UIView{
    
    lazy var blankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tamoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "tamo"
        lbl.formatText(font: "Raleway-Regular", fontSize: 20, color: "primary500")
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    lazy var juntoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "junto"
        lbl.textAlignment = .left
        lbl.formatText(font: "Raleway-Bold", fontSize: 20, color: "primary500")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
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
        self.addSubview(blankView)
        blankView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(tamoLabel)
        labelStackView.addArrangedSubview(juntoLabel)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        blankView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         heightConstant: 80)
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: blankView.topAnchor, constant: 45),
            labelStackView.centerXAnchor.constraint(equalTo: blankView.centerXAnchor),
        ])
        
        juntoLabel.anchor(
            left: tamoLabel.rightAnchor,
            leftConstant: 0)
    }
    
    //MARK: - Setup of the actions
    func setActions(){

    }
    
    
    
}

