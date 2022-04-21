//
//  MainPageView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 08/04/22.
//

import UIKit

class MainPageView: UIView{
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
    lazy var searchBarButton = SearchBarButton()
    
    //topicsLabel
    lazy var topicsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Escolha um tema para conversar:"
        return lbl
    }()
    
    lazy var card = TopicCardNarrow()
    lazy var longCard = TopicCardLong()
    
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
    
    //publicationsLabel
    lazy var publicationsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 16)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "Publicações mais recentes:"
        return lbl
    }()
    
    //publicationsStackView
    lazy var publicationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var post = PostTwoLines()
    lazy var post2 = PostTwoLines()
    lazy var post3 = PostTwoLines()
    lazy var post4 = PostTwoLines()
    
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
        contentView.addSubview(searchBarButton)
        contentView.addSubview(topicsLabel)
        contentView.addSubview(topicsScrollView)
        topicsScrollView.addSubview(topicsScrollStackView)
        topicsScrollStackView.addArrangedSubview(card)
        contentView.addSubview(longCard)
        contentView.addSubview(publicationsLabel)
        contentView.addSubview(publicationsStackView)
        publicationsStackView.addArrangedSubview(post)
        publicationsStackView.addArrangedSubview(post2)
        publicationsStackView.addArrangedSubview(post3)
        publicationsStackView.addArrangedSubview(post4)
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
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
        
        searchBarButton.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         leftConstant: 23,
                         rightConstant: 23,
                         heightConstant: 56)
        
        topicsLabel.anchor(top: searchBarButton.bottomAnchor,
                           left: contentView.leftAnchor,
                           right: contentView.rightAnchor,
                           topConstant: 24,
                           leftConstant: 24,
                           rightConstant: 24,
                           heightConstant: 23)

        NSLayoutConstraint.activate([
            topicsScrollView.topAnchor.constraint(equalTo: topicsLabel.bottomAnchor, constant: 16),
            topicsScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topicsScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topicsScrollView.heightAnchor.constraint(equalToConstant: 240)
        ])

        NSLayoutConstraint.activate([
            topicsScrollStackView.topAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.topAnchor),
            topicsScrollStackView.bottomAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.bottomAnchor),
            topicsScrollStackView.leadingAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.leadingAnchor, constant: 23),
            topicsScrollStackView.trailingAnchor.constraint(equalTo: topicsScrollView.contentLayoutGuide.trailingAnchor, constant: -23)
        ])
        
        longCard.anchor(top: topicsScrollStackView.bottomAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     topConstant: 24,
                     leftConstant: 23,
                     rightConstant: 23)

        publicationsLabel.anchor(top: longCard.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 topConstant: 24,
                                 leftConstant: 23,
                                 rightConstant: 23)
        
        publicationsStackView.anchor(top: publicationsLabel.bottomAnchor,
                    left: contentView.leftAnchor,
                    right: contentView.rightAnchor,
                    topConstant: 16,
                    leftConstant: 23,
                    rightConstant: 23)
        
        showMoreButton.anchor(top: publicationsStackView.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              topConstant: 24,
                              leftConstant: 23,
                              rightConstant: 23)
        
        contentView.anchor(bottom: showMoreButton.bottomAnchor,
                          bottomConstant: -20)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
}

