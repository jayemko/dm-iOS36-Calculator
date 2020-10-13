//
//  ViewController.swift
//  Calculator
//
//  Created by Jason Koceja on 10/12/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var billSubtotalTextfield: CalculatorTextField!
    @IBOutlet weak var tipTotalAmountLabel: UILabel!
    @IBOutlet weak var tipSplitLabel: UILabel!
    @IBOutlet weak var countOfWaysSplitTextField: UITextField!
    
    @IBOutlet weak var tip0Button: CalculatorButton!
    @IBOutlet weak var tip5Button: CalculatorButton!
    @IBOutlet weak var tip10Button: CalculatorButton!
    @IBOutlet weak var tip15Button: CalculatorButton!
    @IBOutlet weak var tip20Button: CalculatorButton!
    
    
    // MARK: - Properties
    
    var viewsLaidOut = false
    var chosenTipPercentage: Double = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billSubtotalTextfield.addTarget(self, action: #selector(currencyFieldChanged), for: .editingChanged)
        countOfWaysSplitTextField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewsLaidOut == false {
            setupViews()
            viewsLaidOut = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction func percentageButtonTapped(_ sender: UIButton) {
        //0,5,10,15,20
        print("[\(#fileID):\(#function):\(#line)] -- \(sender.tag)")
        didSelectTipButton(tag: sender.tag)
        
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        
        self.view.backgroundColor = .blue
        tipSplitLabel.textColor = .white
    }
    
    func didSelectTipButton(tag: Int) {
        let buttons = [tip0Button,tip5Button, tip10Button, tip15Button, tip20Button]
        for button in buttons {
            button?.isChosen = false
        }
        switch tag {
            case 0:
                tip0Button.isChosen = false
                presentCheapAssAlert()
                chosenTipPercentage = 0
            case 5:
                tip5Button.isChosen = true
                chosenTipPercentage = 5
            case 10:
                tip10Button.isChosen = true
                chosenTipPercentage = 10
            case 15:
                tip15Button.isChosen = true
                chosenTipPercentage = 15
            case 20:
                tip20Button.isChosen = true
                chosenTipPercentage = 20
            default:
                chosenTipPercentage = 0
                break
        }
        currencyFieldChanged()
    }
    
    func tipAmountStringForSubtotal(_ subtotal: Double) -> String {
        print("[\(#fileID):\(#function):\(#line)] -- chosentip% \(chosenTipPercentage)")
        return "\(subtotal * Double(chosenTipPercentage / 100))"
    }
    
    @objc func currencyFieldChanged() {
        let subtotal = (billSubtotalTextfield.decimal as NSDecimalNumber).doubleValue
        
        let tipDouble = subtotal * Double(chosenTipPercentage / 100)
        tipTotalAmountLabel.text = String(format: "$%.2f", (subtotal * Double(chosenTipPercentage / 100)))
        
        let splitTipWays = Int(countOfWaysSplitTextField.text!) ?? 1
        tipSplitLabel.text = String(format: "Is $%.2f per person", (tipDouble / Double(splitTipWays)))
    }
    
    @IBAction func tipSplitTextFieldEditingChanged(_ sender: UITextField) {
        currencyFieldChanged()
    }
    
    func presentCheapAssAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Say What?", message: "Don't be a cheap-ass, leave a tip.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok, Fine", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
}

