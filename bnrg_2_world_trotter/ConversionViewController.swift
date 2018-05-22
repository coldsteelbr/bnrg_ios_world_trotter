//
//  ConversionViewController.swift
//  bnrg_2_world_trotter
//
//  Created by Admin on 18.05.2018.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelciusLabel()
        print("Conversion view controller loaded")
    }
    
    // dark/light modes
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        print("Hour: \(hour)")
        
        if hour >= 16 {
            view.backgroundColor = UIColor.brown
        } else {
            view.backgroundColor = UIColor.gray
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // not allowing letters
        let letters = NSCharacterSet.letters
        for unicode in string.unicodeScalars{
            if letters.contains(unicode){
                print("Letters not allowed")
                return false
            }
        }
        
        // avoiding double decimal point
        
        let valueHasDot = textField.text?.range(of: ".")
        let enterHasDot = string.range(of: ".")
        
        print("Value: \(String(describing: valueHasDot?.isEmpty))")
        print("Enter: \(String(describing: enterHasDot?.isEmpty))")
        
        if valueHasDot != nil, enterHasDot != nil {
            return false
        }else{
            return true
        }
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelciusLabel()
        }
    }
    var celciusValue: Measurement<UnitTemperature>? {
        if let F = fahrenheitValue {
            return F.converted(to: UnitTemperature.celsius)
        }else{
            return nil
        }
    }
    
    func updateCelciusLabel(){
        if let cValue = celciusValue{
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: cValue.value))
        }else{
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEdittingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer){
        valueTextField.resignFirstResponder();
    }
}
