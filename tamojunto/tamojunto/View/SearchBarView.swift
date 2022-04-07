//
//  SearchBarView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 06/04/22.
//

import Foundation
import UIKit

class SearchBarView: UIView{
    
    //image
    lazy var magnifyingGlassImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "magnifyingglass")
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    //searchTextField
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Buscar..."
        textField.attributedPlaceholder = NSAttributedString(string: "Buscar...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)])
        textField.font = UIFont(name: "Raleway-Regular", size: 16)
        textField.textColor = UIColor(red: 0.204, green: 0.176, blue: 0.145, alpha: 1)
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //searchBarView
    lazy var searchBarView: UIView = {
        let searchBarView = UIView()
        searchBarView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        searchBarView.layer.cornerRadius = 16
        searchBarView.layer.borderWidth = 1
        searchBarView.layer.borderColor = UIColor(red: 0.718, green: 0.714, blue: 0.678, alpha: 1).cgColor
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        return searchBarView
    }()
    
    //stack
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.32
        stackView.alignment = .leading
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
        self.addSubview(searchBarView)
        searchBarView.addSubview(searchStackView)
        searchStackView.addArrangedSubview(magnifyingGlassImage)
        searchStackView.addArrangedSubview(searchTextField)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        //searchBarView
        NSLayoutConstraint.activate([
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        //searchStackView
        NSLayoutConstraint.activate([
            searchStackView.centerXAnchor.constraint(equalTo: searchBarView.centerXAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 12),
            searchStackView.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -12),
            searchStackView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -9.5),
            searchStackView.topAnchor.constraint(equalTo: searchBarView.topAnchor, constant: 9.5)
        ])
        
        //magnifyingGlassImage
        NSLayoutConstraint.activate([
            magnifyingGlassImage.leadingAnchor.constraint(equalTo:   searchStackView.leadingAnchor),
            magnifyingGlassImage.bottomAnchor.constraint(equalTo:   searchStackView.bottomAnchor),
            magnifyingGlassImage.topAnchor.constraint(equalTo:  searchStackView.topAnchor),
            magnifyingGlassImage.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        //searchTextField
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo:   searchBarView.leadingAnchor, constant: 42),
            searchTextField.bottomAnchor.constraint(equalTo:   searchStackView.bottomAnchor),
            searchTextField.topAnchor.constraint(equalTo:  searchStackView.topAnchor)
        ])
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        
    }
    
}

