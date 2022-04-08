//
//  UILabelExtension.swift
//  tamojunto
//
//  Created by Giovanna Toni on 07/04/22.
//

import UIKit

extension UILabel {
    func formatText(font: String, fontSize: Int, color: String) {
        self.font = UIFont(name: font, size: CGFloat(fontSize))
        self.textColor = UIColor(named: color)
        self.textAlignment = .justified
    }
}
