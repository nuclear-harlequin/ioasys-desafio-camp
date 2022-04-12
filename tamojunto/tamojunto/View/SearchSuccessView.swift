//
//  SearchSuccessView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class SearchSuccessView: UIView{
    lazy var header = Header()
    
    //scrollView
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //contentView
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //searchBar
    lazy var searchBar = SearchBar()
    
    //resultsLabel
    lazy var resultsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Resultados da sua busca:"
        return lbl
    }()
    
    lazy var post = PostTwoLines()
    lazy var post2 = PostTwoLines()
    lazy var post3 = PostTwoLines()
    lazy var post4 = PostTwoLines()
    lazy var post5 = PostTwoLines()
    
    //resultsStackView
    lazy var resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var showMoreButton: LongButton = {
        let btn = LongButton()
        btn.longButton.setTitle("CARREGAR MAIS TÓPICOS", for: .normal)
        btn.longButton.setTitleColor(.white, for: .normal)
        btn.longButton.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
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
        self.addSubview(header)
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(resultsLabel)
        contentView.addSubview(resultsStackView)
        resultsStackView.addArrangedSubview(post)
        resultsStackView.addArrangedSubview(post2)
        resultsStackView.addArrangedSubview(post3)
        resultsStackView.addArrangedSubview(post4)
        resultsStackView.addArrangedSubview(post5)
        contentView.addSubview(showMoreButton)
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
        
        searchBar.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         leftConstant: 23,
                         rightConstant: 23,
                        heightConstant: 56)
        
        resultsLabel.anchor(top: searchBar.bottomAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     topConstant: 24,
                     leftConstant: 24,
                     rightConstant: 24,
                    heightConstant: 23)

        resultsStackView.anchor(top: resultsLabel.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              topConstant: 16,
                              leftConstant: 23,
                              rightConstant: 23)
        
        showMoreButton.anchor(top: resultsStackView.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              topConstant: 24,
                              leftConstant: 23,
                              rightConstant: 23)

        contentView.anchor(bottom: showMoreButton.bottomAnchor,
                          bottomConstant: -30)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

