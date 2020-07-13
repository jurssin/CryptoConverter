//
//  QuoteCached.swift
//  CryptoConverter
//
//  Created by User on 11/21/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import RealmSwift

class QuoteCached: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var rank = 0
    @objc dynamic var priceUSD = ""
    @objc dynamic var priceBTC = ""
    @objc dynamic var volumeUSD24H = ""
    @objc dynamic var marketCapUSD = ""
    @objc dynamic var availableSupply = ""
    @objc dynamic var totalSupply = ""
    @objc dynamic var maxSupply: String?
    @objc dynamic var percentChange1h = ""
    @objc dynamic var percentChange24h = ""
    @objc dynamic var percentChange7d = ""
    @objc dynamic var lastUpdated = ""
    
    override class func primaryKey() -> String? {
        return "rank"
    }
    
    convenience init(quote: Quote) {
        self.init()
        self.id = quote.id
        self.symbol = quote.symbol
        self.name = quote.name
        self.rank = Int(quote.rank) ?? 0
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
    
}
