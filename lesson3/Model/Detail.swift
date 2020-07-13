//
//  Detail.swift
//  lesson3
//
//  Created by User on 11/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class Detail {
    private init() {
        
    }
    static let headerTitles = ["API Info", "Price", "Percent Change", "Market Stats", "Supply Stats"]
    static let numberOfRowsInEachSection = [3, 2, 3, 2, 3]
    static func textForRow(quote: Quote) -> [[String]] {
        
        let textForRow = [
        [
            "ID: \(quote.id)",
            "Rank: \(quote.rank)",
            "Last updated: \(Formatter.dataFormatter(Int(quote.lastUpdated) ?? 0))"
        ],
        [
            "\(String(format: "%.2f", Double(quote.priceUSD) ?? 0)) USD",
            "\(String(format: "%.2f", Double(quote.priceBTC) ?? 0)) BTC",
        ],
        [
            "Last hour: \(String(format: "%.2f", Double(quote.percentChange1h) ?? 0))%",
            "Last day: \(String(format: "%.2f", Double(quote.percentChange24h) ?? 0))%",
            "Last week: \(String(format: "%.2f", Double(quote.percentChange7d) ?? 0))%"
        ],
        [
            "Volume (24h): $\(Formatter.numberFormatter(Double(quote.volumeUSD24H) ?? 0))",
            "Market cap: $\(Formatter.numberFormatter(Double(quote.marketCapUSD) ?? 0))"
        ],
        [
            "Available supply: \(Formatter.numberFormatter(Double(quote.availableSupply) ?? 0) ) \(quote.symbol)",
            "Total supply: \(Formatter.numberFormatter(Double(quote.totalSupply) ?? 0)) \(quote.symbol)",
            "Maximum supply: \((quote.maxSupply) ?? String(0)) \(quote.symbol)"
        ]
        ]
        
        return textForRow

    }
}

