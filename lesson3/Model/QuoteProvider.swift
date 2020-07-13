//
//  QuoteProvider.swift
//  lesson3
//
//  Created by User on 11/5/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class QuoteProvider {
    
    private var quoteArray: [Quote] = []
    private var oldQuotePrices: [String: String] = [:]
    private let address = "https://api.coinmarketcap.com/v1/ticker"
    
    init() {
        self.loadQuotes()
    }
    
    var timer: Timer?
    
    private func sendNotification() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendQuoteArray"), object:  quoteArray, userInfo: oldQuotePrices)
    }
    
    func restartTimer(timeInterval: Double = 300.0) {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.loadQuotes()
        }
    }
    @objc func loadQuotes() {
        
        guard let url = URL(string: address) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) {
            [weak self]
            (data, response, error) in
            if let data = data {
                print("isValid data: \(data)")
                if let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
                    self?.oldQuotePrices = [:]
                    self?.quoteArray.forEach { (quote) in
                        self?.oldQuotePrices[quote.symbol] = quote.priceUSD
                        
                    }
                    self?.quoteArray = quotes
                    print("quotes: \(quotes)")
                    DispatchQueue.main.async {
                        self?.sendNotification()
                    }
                }
            }
        }
        dataTask.resume()
    }
}

