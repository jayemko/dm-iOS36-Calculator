//
//  CalculatorTextField.swift
//  Calculator
//
//  Created by Jason Koceja on 10/12/20.
//

import UIKit

class CalculatorTextField : UITextField {
    
    private var enteredNumbers = ""
    private var didBackspace = false
    private var lastValue: String?
    var decimal: Decimal { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
    var maximum: Decimal = 999_999_999.99
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.locale = Locale(identifier: "en_US")
        Formatter.currency.locale = locale
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    override func deleteBackward() {
        text = string.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    
    @objc func editingChanged() {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = decimal.currency
        lastValue = text
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    // MARK: - Extension functions
    
    func setupViews() {
        
        self.addCornerRadius(radius: 15)
        self.layer.masksToBounds = true
        
        self.addAccentBorder()
        self.textColor = .darkText
        self.backgroundColor = .white
    }
}

extension UITextField {
    var string: String { text ?? "" }
}

extension CalculatorTextField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

private extension Formatter {
    static let currency: NumberFormatter = .init(numberStyle: .currency)
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}
extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
