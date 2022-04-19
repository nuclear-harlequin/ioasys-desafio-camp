//
//  ImageCard.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class ImageCard: UIView{

    //imageView
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(named: "neutral60")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        img.layer.shadowOpacity = 1
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
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
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        imageView.anchor(top: topAnchor,
                                     left: leftAnchor,
                                     bottom: bottomAnchor,
                                     right: rightAnchor)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

