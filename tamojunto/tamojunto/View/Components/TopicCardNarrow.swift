//
//  TopicCardNarrow.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 08/04/22.
//

import Foundation
import UIKit

class TopicCardNarrow: UIView{
    //imageView
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(named: "neutral60")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 12
        img.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        img.layer.shadowOpacity = 0.15
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //bannerView
    lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //commentNumberView
    lazy var commentNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary500")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "3"
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var commentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "novos"
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var topicNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Administração"
        lbl.textColor = UIColor(named: "primary500")
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textAlignment = .justified
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //stroke
    lazy var stroke: UIView = {
        var stroke = UIView()
        stroke.backgroundColor = UIColor(named: "primary80")
        stroke.translatesAutoresizingMaskIntoConstraints = false
        return stroke
    }()
    
    lazy var topicNumberLabel: UILabel = {
        let lbl = UILabel()
        let topicNumber = "12"
        lbl.text = "\(topicNumber) Tópicos"
        lbl.textColor = UIColor(named: "primary500")
        lbl.font = UIFont(name: "Raleway-Regular", size: 13)
        lbl.textAlignment = .justified
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var commentsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -9
        stackView.distribution = .fillEqually
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
        self.addSubview(imageView)
        imageView.addSubview(bannerView)
        bannerView.addSubview(topicNameLabel)
        bannerView.addSubview(stroke)
        bannerView.addSubview(topicNumberLabel)
        imageView.addSubview(commentNumberView)
        commentNumberView.addSubview(commentsStack)
        commentsStack.addArrangedSubview(commentNumberLabel)
        commentsStack.addArrangedSubview(commentLabel)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        
        imageView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         widthConstant: 164,
                         heightConstant: 240)
        
        bannerView.anchor(
            left: imageView.leftAnchor,
            bottom: imageView.bottomAnchor,
            right: imageView.rightAnchor,
            widthConstant: 164,
            heightConstant: 120)
        
        topicNameLabel.anchor(top: bannerView.topAnchor,
                              left: bannerView.leftAnchor,
                              right: bannerView.rightAnchor,
                              topConstant: 65,
                              leftConstant: 9,
                              rightConstant: 44)
        
        stroke.anchor(top: topicNameLabel.bottomAnchor,
                      left: bannerView.leftAnchor,
                      right: bannerView.rightAnchor,
                      leftConstant: 8,
                      rightConstant: 8,
                      heightConstant: 1)
        
        topicNumberLabel.anchor(top: stroke.bottomAnchor,
                                left: bannerView.leftAnchor,
                                right: bannerView.rightAnchor,
                                leftConstant: 9,
                                rightConstant: 89)
        
        commentNumberView.anchor(top: imageView.topAnchor,
                                 left: imageView.leftAnchor,
                                 right: imageView.rightAnchor,
                                 topConstant: 106,
                                 leftConstant: 100,
                                 rightConstant: 16,
                                 widthConstant: 48,
                                 heightConstant: 48)
        
        commentsStack.anchorCenterSuperview()
        
//                commentNumberLabel.anchor(top: commentNumberView.topAnchor,
//                                    left: commentNumberView.leftAnchor,
//                                    right: commentNumberView.rightAnchor,
//                                          topConstant: 8,
//                                          leftConstant: 14,
//                                    rightConstant: 14,
//                                    widthConstant: 20,
//                                    heightConstant: 20)
        
//        commentLabel.anchor(top: commentNumberView.topAnchor,
//                            left: commentNumberView.leftAnchor,
//                            bottom: commentNumberView.bottomAnchor,
//                            right: commentNumberView.rightAnchor,
//                            topConstant: 24.5,
//                            leftConstant: 5.5,
//                            bottomConstant: 4.5,
//                            rightConstant: 5.5,
//                            widthConstant: 37,
//                            heightConstant: 19)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

