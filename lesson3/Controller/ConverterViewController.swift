//
//  ConverterViewController.swift
//  CryptoConverter
//
//  Created by User on 11/14/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var baseQuote: Quote?
    var convertQuote: Quote?
    var converter = Converter()

    @IBOutlet weak var convertQuoteButton: UIButton!
    @IBOutlet weak var baseQuoteButton: UIButton!
    @IBOutlet weak var convertQuoteTextField: UITextField!
    @IBOutlet weak var baseQuoteLabel: UILabel!
    @IBOutlet weak var convertQuoteLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PopOverTableViewController {
            destination.delegate = self
            if let identifier = segue.identifier {
                destination.senderSegue = identifier
            }
        }
    }
}

extension ConverterViewController: SelectQuoteDelegate {
    
    func baseQuoteSelected(_ quote: Quote) {
        baseQuote = quote
        baseQuoteButton.setTitle("", for: .normal)
        baseQuoteButton.setImage(UIImage(named: quote.id), for: .normal)
        baseQuoteButton.backgroundColor = .none
        baseQuoteLabel.text = quote.name
        converter.baseQuote = quote
    }
    
    func convertQuoteSelected(_ quote: Quote) {
        convertQuote = quote
        convertQuoteButton.setTitle("", for: .normal)
        convertQuoteButton.setImage(UIImage(named: quote.id), for: .normal)
        convertQuoteButton.backgroundColor = .none
        convertQuoteLabel.text = quote.name
        converter.convertQuote = quote
    }
}

extension ConverterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let baseQuote = baseQuote else {
           convertQuoteTextField.text = "Select Base Quote!"
            return
    }
        guard let convertQuote = convertQuote else {
            convertQuoteTextField.text = "Select Convert Quote!"
            return
    }
        if let text = textField.text {
            if let amount = Double(text) {
                textField.text = "\(text) \(baseQuote.symbol)"
                convertQuoteTextField.text = "\(String(format: "%.2f", converter.currencyConverter(amount: amount))) \(convertQuote.symbol)"
            }
            else {
                convertQuoteTextField.text = "Invalid amount"
            }
      }
   }
}
    
    



