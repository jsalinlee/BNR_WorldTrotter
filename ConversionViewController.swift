//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Jonathan Salin Lee on 6/6/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter();
        nf.numberStyle = .decimal;
        nf.minimumFractionDigits = 0;
        nf.maximumFractionDigits = 1;
        return nf;
    }()
    
    @IBOutlet var celsiusLabel: UILabel!;
    @IBOutlet var textField: UITextField!;
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel();
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius);
        } else {
            return nil;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        print("ConversionViewController loaded its view.");
        
        updateCelsiusLabel();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date();
        let calendar = Calendar.current;
        if (calendar.component(.hour, from: date) >= 18) {
            view.backgroundColor = UIColor.blue;
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit);
        } else {
            fahrenheitValue = nil;
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder();
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value));
        } else {
            celsiusLabel.text = "???";
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current;
        let decimalSeparator = currentLocale.decimalSeparator ?? ".";
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator);
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator);
        
        let onlyDigits = string.rangeOfCharacter(from: NSCharacterSet.letters);
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil || onlyDigits != nil {
            return false;
        } else {
            return true;
        }
    }
}
