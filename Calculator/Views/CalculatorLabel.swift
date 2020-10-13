//
//  CalculatorLabel.swift
//  Calculator
//
//  Created by Jason Koceja on 10/12/20.
//

import UIKit

class CalculatorLabel : UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textColor = .white
    }
}

class CalculatorLabelLight : CalculatorLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textColor = .ltTaupe
    }
}

class CalculatorLabelBold : CalculatorLabel {
    
}
