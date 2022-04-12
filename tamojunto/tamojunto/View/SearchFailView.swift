//
//  SearchFailView.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class SearchFailView: UIView{
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
    
    lazy var noResultsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Regular", size: 16)
        lbl.textColor = UIColor(named: "primary800")
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let string = """
        Sentimos muito!\n
        Infelizmente não encontramos resultados para “Palavra-chave buscada”.\n
        Verifique a ortografia ou busque por termos relacionados.
        """
        lbl.attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return lbl
    }()
  
    //imageView
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "searchFail")
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 12
        return imgView
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
        contentView.addSubview(noResultsLabel)
        contentView.addSubview(imageView)
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
        
        noResultsLabel.anchor(top: searchBar.bottomAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     topConstant: 24,
                     leftConstant: 24,
                     rightConstant: 24)

        imageView.anchor(top: noResultsLabel.bottomAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         topConstant: 16,
                         leftConstant: 24,
                         rightConstant: 24,
        heightConstant: 224)

//        contentView.anchor(bottom: showMoreButton.bottomAnchor,
//                          bottomConstant: -30)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

