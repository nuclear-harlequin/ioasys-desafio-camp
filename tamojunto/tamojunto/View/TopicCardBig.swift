//
//  TopicCardBig.swift
//  tamojunto
//
//  Created by Giovanna Toni on 06/04/22.
//

import UIKit

class TopicCardBig: UIViewController {

    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.alpha = 0.95
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Compra, Venda e Aluguel"
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        label.textColor = UIColor(named: "primary500")
        return label
    }()
    
    private lazy var numberOfTopicsLabel: UILabel = {
        let label = UILabel()
        label.text = String(12) + "tópicos"
        label.font = UIFont(name: "Raleway-Regular", size: 13)
        label.textColor = UIColor(named: "primary500")
        return label
    }()
    
    private lazy var numberOfNewTopicsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "primary500")
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        label.textColor = .white
        label.text = "6 novos"
        return label
    }()

}
