//
//  CommentView.swift
//  tamojunto
//
//  Created by Giovanna Toni on 08/04/22.
//

import UIKit

class CommentView: UITableViewCell {
    
    lazy var blankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.addShadow(radius: 12)
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let lbl = UILabel()
        var author = "Author's name"
        var date = "dd/mm/aa"
        lbl.formatText(font: "Raleway-Regular", fontSize: 13, color: "primary800")
        lbl.text = "\(author) in \(date)"
        return lbl
    }()
    
    lazy var contentLabel: UILabel = {
        let lbl = UILabel()
        var content = """
            Curabitur vehicula at orci ut gravida. Donec et elit metus. \
            Nullam sit amet est et augue gravida consequat. Suspendisse eu gravida mi. \
            Aenean libero justo, sodales sit amet tellus non, aliquet finibus lacus. \
            Donec quis accumsan eros. In auctor, urna in laoreet finibus, \
            odio justo lacinia lorem, vel maximus mauris elit non ante. \
            Etiam sed magna non massa pulvinar fringilla.
            """
        lbl.formatText(font: "Raleway-Regular", fontSize: 13, color: "primary800")
        lbl.text = content
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentView: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(blankView)
        blankView.addSubview(infoLabel)
        blankView.addSubview(contentLabel)
    }
    
    func setupConstraints() {
        blankView.anchorTo(superview: self)
        
        infoLabel.anchor(top: blankView.topAnchor,
                         left: blankView.leftAnchor,
                         bottom: contentLabel.topAnchor,
                         right: blankView.rightAnchor,
                         topConstant: 24,
                         leftConstant: 24,
                         bottomConstant: 8,
                         rightConstant: 22)
        
        contentLabel.anchor(top: infoLabel.bottomAnchor,
                            left: blankView.leftAnchor,
                            bottom: blankView.bottomAnchor,
                            right: blankView.rightAnchor,
                            topConstant: 8,
                            leftConstant: 24,
                            bottomConstant: 24,
                            rightConstant: 22)
    }
    
    func setupAdditionalConfiguration() {
        contentLabel.numberOfLines = .max
        contentLabel.lineBreakMode = .byWordWrapping
    }
}
