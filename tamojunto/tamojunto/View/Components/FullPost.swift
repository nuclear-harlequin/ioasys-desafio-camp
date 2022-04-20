//
//  FullPost.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 07/04/22.
//

import Foundation
import UIKit

class FullPost: UIView{
    //postView
    lazy var postView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    //authorTextView
    lazy var authorTextView: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Italic", size: 13)
        lbl.textColor = UIColor(red: 0.008, green: 0.071, blue: 0.059, alpha: 1)
        lbl.text = "Autor do Post em dd/mm/aa"
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
    
    //messageTextView
    lazy var titleTextView: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textColor = UIColor(red: 0.008, green: 0.071, blue: 0.059, alpha: 1)
        
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
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
    
    //commentsTextView
    lazy var commentsTextView: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Bold", size: 13)
        lbl.textColor = UIColor(red: 0.008, green: 0.071, blue: 0.059, alpha: 1)
        lbl.text = "XXX comentários"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //messageTextView
    lazy var messageTextView: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Raleway-Regular", size: 13)
        lbl.textColor = UIColor(red: 0.008, green: 0.071, blue: 0.059, alpha: 1)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        lbl.text = "Placeholder"
        lbl.attributedText = NSMutableAttributedString(string: lbl.text ?? "FAIL", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        self.addSubview(postView)
        postView.addSubview(button)
        postView.addSubview(authorTextView)
        postView.addSubview(stroke)
        postView.addSubview(titleTextView)
        postView.addSubview(commentsTextView)
        postView.addSubview(messageTextView)
    }
    
    //MARK: - Setup of the cnstraints
    func setConstraints(){

        postView.anchor(top: topAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor)
        
        button.anchor(top: postView.topAnchor,
                      left: postView.leftAnchor,
                      bottom: titleTextView.topAnchor,
                      right: postView.rightAnchor,
                      topConstant: 10,
                      leftConstant: 290,
                      bottomConstant: 30)
        
        authorTextView.anchor(top: button.bottomAnchor,
                              left: postView.leftAnchor,
                              right: postView.rightAnchor,
                              topConstant: 4,
                              leftConstant: 23,
                              rightConstant: 23)
        
        stroke.anchorCenterXToSuperview()
        stroke.anchor(top: authorTextView.bottomAnchor,
                      left: postView.leftAnchor,
                      right: postView.rightAnchor,
                      topConstant: 4,
                      leftConstant: 23,
                      rightConstant: 23,
                      heightConstant: 1)
        
        titleTextView.anchor(top: stroke.bottomAnchor,
                             left: postView.leftAnchor,
                             right: postView.rightAnchor,
                             topConstant: 8,
                             leftConstant: 23,
                             rightConstant: 23)
        
        commentsTextView.anchor(top: titleTextView.bottomAnchor,
                                left: postView.leftAnchor,
                                right: postView.rightAnchor,
                                topConstant: 16,
                                leftConstant: 23,
                                rightConstant: 23)
        
        messageTextView.anchor(top: commentsTextView.bottomAnchor,
                               left: postView.leftAnchor,
                               right: postView.rightAnchor,
                               topConstant: 22.49,
                               leftConstant: 23,
                               rightConstant: 23)

       postView.anchor(bottom: messageTextView.bottomAnchor,
                       bottomConstant: -28.64)        
    }
    
    //MARK: - Setup of the actions
    func setActions(){
        //action set in view controller
    }
    
    
    
}

