//
//  PostView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

class PostView: UIView {
    
    lazy var blankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.addShadow(radius: 12)
        return view
    }()
    
    lazy var postInfoLabel: UILabel = {
        let lbl = UILabel()
        var author = "Author's name"
        var date = "dd/mm/aa"
        lbl.formatText(font: "Raleway-Regular", fontSize: 13, color: "primary800")
        lbl.text = "\(author) in \(date)"
        return lbl
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary80")
        return view
    }()
    
    lazy var postTitleLabel: UILabel = {
        let lbl = UILabel()
        var title = "Título Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut id lacus vel blandit..."
        lbl.formatText(font: "Raleway-Bold", fontSize: 13, color: "primary800")
        lbl.text = title
        return lbl
    }()
    
    lazy var postContentLabel: UILabel = {
        let lbl = UILabel()
        var content = """
            Cinco primeiras linhas do post: Lorem ipsum dolor sit amet, \
            consectetur adipiscing elit. Lorem ipsum dolor sit amet, \
            consectetur adipiscing elit. Lorem ipsum dolor sit amet, \
            consectetur adipiscing elit.
            """
        lbl.formatText(font: "Raleway-Regular", fontSize: 13, color: "primary800")
        lbl.text = content
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PostView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(blankView)
        blankView.addSubview(postInfoLabel)
        blankView.addSubview(lineView)
        blankView.addSubview(postTitleLabel)
        blankView.addSubview(postContentLabel)
    }
    
    func setupConstraints() {
        blankView.anchorTo(superview: self)
        
        postInfoLabel.anchor(top: blankView.topAnchor,
                             left: blankView.leftAnchor,
                             bottom: lineView.topAnchor,
                             right: blankView.rightAnchor,
                             topConstant: 22.62,
                             leftConstant: 25.85,
                             bottomConstant: 6.41,
                             rightConstant: 25.85)
        
        lineView.anchor(top: postInfoLabel.bottomAnchor,
                        left: blankView.leftAnchor,
                        bottom: postTitleLabel.topAnchor,
                        right: blankView.rightAnchor,
                        topConstant: 6.41,
                        leftConstant: 24,
                        bottomConstant: 8.02,
                        rightConstant: 22,
                        heightConstant: 1)
        
        postTitleLabel.anchor(top: lineView.bottomAnchor,
                              left: blankView.leftAnchor,
                              bottom: postContentLabel.topAnchor,
                              right: blankView.rightAnchor,
                              topConstant: 8.02,
                              leftConstant: 24,
                              bottomConstant: 8.02,
                              rightConstant: 22)
        
        postContentLabel.anchor(top: postTitleLabel.bottomAnchor,
                                left: blankView.leftAnchor,
                                bottom: blankView.bottomAnchor,
                                right: blankView.rightAnchor,
                                topConstant: 8.02,
                                leftConstant: 24,
                                bottomConstant: 14,
                                rightConstant: 22)
    }
    
    func setupAdditionalConfiguration() {
        postInfoLabel.lineBreakMode = .byTruncatingTail
        postInfoLabel.numberOfLines = 1
        
        postTitleLabel.numberOfLines = 2
        postTitleLabel.lineBreakMode = .byTruncatingTail
        
        postContentLabel.numberOfLines = 5
        postContentLabel.lineBreakMode = .byTruncatingTail
    }
    
    
}
