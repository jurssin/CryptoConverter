//
//  Converter.swift
//  lesson3
//
//  Created by User on 11/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class Converter {
    
    var baseQuote: Quote?
    var convertQuote: Quote?
    
    func currencyConverter(amount: Double) -> Double {
        
        guard let baseQuote = baseQuote else {
            return Double()
        }
        guard let baseQuotePrice = Double(baseQuote.priceUSD) else {
            return Double()
        }
        guard let convertQuote = convertQuote else {
            return Double()
        }
        
        guard let convertQuotePrice = Double(convertQuote.priceUSD) else {
            return Double()
        }
        return (amount * baseQuotePrice) / convertQuotePrice
    }
}

