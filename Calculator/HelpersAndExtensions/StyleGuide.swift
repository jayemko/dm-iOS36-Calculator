//
//  StyleGuide.swift
//  Calculator
//
//  Created by Jason Koceja on 10/12/20.
//

import UIKit

struct FontNames {
    static let digitalRegular = "Digital-Regular"
}

extension UIColor {
    static let taupe = UIColor(named: "taupe")!
    static let peach = UIColor(named: "peach")!
    static let orange = UIColor(named: "orange")!
    static let blue = UIColor(named: "blue")!
    static let cyan = UIColor(named: "cyan")!
    static let ltTaupe = UIColor(named: "ltTaupe")!
    static let white = UIColor(named: "white")!
    static let borderHighlight = UIColor(named: "borderHighlight")!
}

extension UIView {
    func addCornerRadius(radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 2, color: UIColor = .borderHighlight) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
