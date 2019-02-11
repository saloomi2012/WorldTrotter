//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Suliman Alsaid on 2/4/19.
//  Copyright © 2019 Suliman Alsaid. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet  {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String ) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let existingTextHasDash = textField.text?.range(of: "-")
        let replacementTextHasDash = string.range(of: "-")
        
        let replacementTextHasAlphabeticCharacter = string.rangeOfCharacter(from: NSCharacterSet.letters)
        let replacementTextHasPunctuation = string.rangeOfCharacter(from: NSCharacterSet.punctuationCharacters)
        let replacementTextHasSymbols = string.rangeOfCharacter(from: NSCharacterSet.symbols)
        let replacementTextHasWhiteSpace = string.rangeOfCharacter(from: NSCharacterSet.whitespaces)
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else if existingTextHasDash != nil, replacementTextHasDash != nil {
            return false
        } else if replacementTextHasAlphabeticCharacter != nil {
            return false
            
        } else if replacementTextHasPunctuation != nil {
            if(replacementTextHasDecimalSeparator != nil ) {
                return true
            } else if(replacementTextHasDash != nil && textField.text?.count == 0) {
                return true
            }
            else {
                return false
            }
        } else if replacementTextHasSymbols != nil {
            return false
        } else if replacementTextHasWhiteSpace != nil {
            return false
        } else {
            return true
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    @IBAction func fahrenheitFieldEditingChange(_ textfield: UITextField) {
        if let text = textfield.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        
        if let celsiusValue = celsiusValue {
            //print(celsiusValue)
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Conversion Loaded!")
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let def = UIColor(displayP3Red: 0xF5/0xFF, green: 0xF4/0xFF, blue: 0xF1/0xFF, alpha: 1)
        
        if(hour > 18) {
            self.view.backgroundColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        } else {
            self.view.backgroundColor = def
        }
    }
    
}
