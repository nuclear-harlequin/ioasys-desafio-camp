//
//  PostThreeLines.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 11/04/22.
//

import Foundation
import UIKit

class PostThreeLines: UIView{
    lazy var blankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 8
        return view
    }()
    
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Tema do tópico"
        lbl.formatText(font: "Raleway-Bold", fontSize: 13, color: "primary500")
        return lbl
    }()
    
    lazy var postInfoLabel: UILabel = {
        let lbl = UILabel()
        var author = "Author's name"
        var date = "dd/mm/aa"
        lbl.formatText(font: "Raleway-Regular", fontSize: 13, color: "primary800")
        lbl.text = "\(author) in \(date)"
        return lbl
    }()
    
    lazy var button: UIButton = {
        let bttn = UIButton()
        let buttonImageConfig = UIImage.SymbolConfiguration(pointSize: 18)
        bttn.setImage(UIImage(systemName: "x.square", withConfiguration: buttonImageConfig), for: .normal)
        bttn.imageView?.contentMode = .scaleAspectFit
        bttn.contentMode = .scaleAspectFit
        bttn.tintColor = UIColor(named: "primary500")
        return bttn
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary80")
        return view
    }()
    
    lazy var postTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textColor = UIColor(named: "primary800")
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.textAlignment = .justified
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let string = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer consectetur lectus dui, id sollicitudin elit dapibus id.
        """
        lbl.attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var postContentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Regular", size: 13)
        lbl.textColor = UIColor(named: "primary800")
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 3
        lbl.textAlignment = .justified
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        let string = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer consectetur lectus dui, id sollicitudin elit dapibus id. Integer consectetur lectus dui, id sollicitudin elit dapibus id.
        """
        lbl.attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var commentsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textColor = UIColor(named: "primary500")
        lbl.text = "XXX Comentários"
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var newLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textColor = UIColor(named: "secondary700")
        lbl.text = ""
        lbl.textAlignment = .right
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        self.addSubview(blankView)
        blankView.addSubview(postInfoLabel)
        blankView.addSubview(button)
        blankView.addSubview(lineView)
        blankView.addSubview(postTitleLabel)
        blankView.addSubview(postContentLabel)
        blankView.addSubview(labelsStack)
        labelsStack.addArrangedSubview(commentsLabel)
        labelsStack.addArrangedSubview(newLabel)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){
        blankView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         heightConstant: 200)
        
        postInfoLabel.anchor(top: blankView.topAnchor,
                             left: blankView.leftAnchor,
                             right: blankView.rightAnchor,
                             topConstant: 24,
                             leftConstant: 26,
                             rightConstant: 26)
        
        button.anchor(top: blankView.topAnchor,
                      left: blankView.leftAnchor,
                      bottom: postTitleLabel.topAnchor,
                      right: blankView.rightAnchor,
                      topConstant: 10,
                      leftConstant: 290,
                      bottomConstant: 20,
                      rightConstant: 10)
        
        lineView.anchor(top: postInfoLabel.bottomAnchor,
                        left: blankView.leftAnchor,
                        right: blankView.rightAnchor,
                        topConstant: 4,
                        leftConstant: 24,
                        rightConstant: 24,
                        heightConstant: 1)
        
        postTitleLabel.anchor(top: lineView.bottomAnchor,
                              left: blankView.leftAnchor,
                              right: blankView.rightAnchor,
                              topConstant: 8,
                              leftConstant: 24,
                              rightConstant: 24)
        
        postContentLabel.anchor(top: postTitleLabel.bottomAnchor,
                                left: blankView.leftAnchor,
                                right: blankView.rightAnchor,
                                topConstant: 7.49,
                                leftConstant: 24,
                                rightConstant: 24)
        
        labelsStack.anchor(top: postContentLabel.bottomAnchor,
                           left: blankView.leftAnchor,
                           right: blankView.rightAnchor,
                           topConstant: 8,
                           leftConstant: 24,
                           rightConstant: 24)
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

