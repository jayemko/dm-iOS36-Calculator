//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Jason Koceja on 10/12/20.
//

import UIKit

class CalculatorButton : UIButton {
    
    var isChosen = false {
        didSet {
            switch isChosen {
                case true:
                    viewForSelected()
                case false:
                    viewForNormal()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    // MARK: - Extension functions
    
    func setupView() {
        switch self.state {
            case .normal:
                viewForNormal()
            case .highlighted,
                 .selected,
                 .application:
                viewForSelected()
            default:
                break // for now
        }
    }
    
    func updateFont(font: String){
        guard let size = self.titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: font, size: size)
    }
    
    func viewForNormal() {
        self.setBackgroundColor(.peach, for: .normal)
        self.addAccentBorder(width: 8, color: .borderHighlight)
        self.setTitleColor(.ltTaupe, for: .normal)
        self.addCornerRadius(radius: 4)
        self.layer.masksToBounds = true
    }
    
    func viewForSelected() {
        self.setBackgroundColor(.orange, for: .normal)
        self.addAccentBorder(width: 2, color: .white)
        self.setTitleColor(.white, for: .normal)
        self.addCornerRadius(radius: 4)
        self.layer.masksToBounds = true
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(with: color), for: state)
    }
    
    private func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
