//
//  Quote.swift
//  lesson3
//
//  Created by User on 11/5/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import RealmSwift

class Quote: Decodable {
    
    var id = ""
    var name = ""
    var symbol = ""
    var rank = ""
    var priceUSD = ""
    var priceBTC = ""
    var volumeUSD24H = ""
    var marketCapUSD = ""
    var availableSupply = ""
    var totalSupply = ""
    var maxSupply: String?
    var percentChange1h = ""
    var percentChange24h = ""
    var percentChange7d = ""
    var lastUpdated = ""
    
    
    convenience init(quote: QuoteCached) {
        self.init()
        self.id = quote.id
        self.name = quote.name
        self.symbol = quote.symbol
        self.rank = String(quote.rank)
        self.priceUSD = quote.priceUSD
        self.priceBTC = quote.priceBTC
        self.volumeUSD24H = quote.volumeUSD24H
        self.marketCapUSD = quote.marketCapUSD
        self.availableSupply = quote.availableSupply
        self.totalSupply = quote.totalSupply
        self.maxSupply = quote.maxSupply
        self.percentChange1h = quote.percentChange1h
        self.percentChange24h = quote.percentChange24h
        self.percentChange7d = quote.percentChange7d
        self.lastUpdated = quote.lastUpdated
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case volumeUSD24H = "24h_volume_usd"
        case marketCapUSD = "market_cap_usd"
        case availableSupply = "available_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
        case lastUpdated = "last_updated"
    }
    
}
