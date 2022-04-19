//
//  TopicMainPageView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class TopicMainPageView: UIView{
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
    
    //topicsLabel
    lazy var breadcrumbs: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Home > Administração"
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var topicImageCard = ImageCard()
    
    //topicLabel
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Administração"
        return lbl
    }()
    
    //publicationsStackView
    lazy var publicationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var post = PostThreeLines()
    lazy var post2 = PostThreeLines()
    lazy var post3 = PostThreeLines()
    
    lazy var showMoreButton: LongButton = {
        let btn = LongButton()
        btn.longButton.setTitle("CARREGAR MAIS TÓPICOS", for: .normal)
        btn.longButton.setTitleColor(.white, for: .normal)
        btn.longButton.layer.backgroundColor = UIColor(named: "primary500")?.cgColor
        btn.layer.borderColor = UIColor(named: "primary500")?.cgColor
        return btn
    }()
    
    //exploreLabel
    lazy var exploreLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Explore outros temas:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //topicsScrollView
    lazy var topicsScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //topicsScrollContentView
    lazy var topicsScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var topic = TopicCardSmall()
    lazy var topic2 = TopicCardSmall()
    lazy var topic3 = TopicCardSmall()
    
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
        contentView.addSubview(breadcrumbs)
        contentView.addSubview(topicImageCard)
        contentView.addSubview(topicLabel)
        contentView.addSubview(publicationsStackView)
        publicationsStackView.addArrangedSubview(post)
        publicationsStackView.addArrangedSubview(post2)
        publicationsStackView.addArrangedSubview(post3)
        contentView.addSubview(showMoreButton)
        contentView.addSubview(exploreLabel)
        contentView.addSubview(topicsScrollView)
        topicsScrollView.addSubview(topicsScrollStackView)
        topicsScrollStackView.addArrangedSubview(topic)
        topicsScrollStackView.addArrangedSubview(topic2)
        topicsScrollStackView.addArrangedSubview(topic3)
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
        
        breadcrumbs.anchor(top: searchBar.bottomAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     topConstant: 24,
                     leftConstant: 24,
                     rightConstant: 24,
                    heightConstant: 23)

        topicImageCard.anchor(top: breadcrumbs.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              topConstant: 16.5,
                              leftConstant: 23,
                              rightConstant: 23,
                             heightConstant: 120)

        topicLabel.anchor(top: topicImageCard.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 topConstant: 16,
                                 leftConstant: 24,
                                 rightConstant: 24)
        
        publicationsStackView.anchor(top: topicLabel.bottomAnchor,
                    left: contentView.leftAnchor,
                    right: contentView.rightAnchor,
                    topConstant: 16,
                    leftConstant: 23,
                    rightConstant: 23)
        
        showMoreButton.anchor(top: publicationsStackView.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              topConstant: 22,
                              leftConstant: 23,
                              rightConstant: 23)
        
        exploreLabel.anchor(top: showMoreButton.bottomAnchor,
                            left: contentView.leftAnchor,
                            right: contentView.rightAnchor,
                            topConstant: 24,
                            leftConstant: 23,
                            rightConstant: 23)
        
        NSLayoutConstraint.activate([
            topicsScrollView.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 16),
            topicsScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topicsScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topicsScrollView.heightAnchor.constraint(equalToConstant: 120)
        ])

        NSLayoutConstraint.activate([
            topicsScrollStackView.topAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.topAnchor),
            topicsScrollStackView.bottomAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.bottomAnchor),
            topicsScrollStackView.leadingAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.leadingAnchor, constant: 24),
            topicsScrollStackView.trailingAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.trailingAnchor, constant: -24)
        ])
        
        contentView.anchor(bottom: topicsScrollView.bottomAnchor,
                          bottomConstant: -66)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

