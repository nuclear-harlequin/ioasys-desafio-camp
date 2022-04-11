//
//  TopicCardSmall.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class TopicCardSmall: UIView{
    //imageView
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(named: "neutral60")
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
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topicNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Finanças"
        lbl.textColor = UIColor(named: "primary500")
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        
        imageView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         widthConstant: 164,
                         heightConstant: 120)
        
        bannerView.anchor(
            left: imageView.leftAnchor,
            bottom: imageView.bottomAnchor,
            right: imageView.rightAnchor,
            widthConstant: 164,
            heightConstant: 24)
        
        topicNameLabel.anchor(top: bannerView.topAnchor,
                              left: bannerView.leftAnchor,
                              right: bannerView.rightAnchor,
                              topConstant: 2.5,
                              leftConstant: 54,
                              rightConstant: 54)
        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

