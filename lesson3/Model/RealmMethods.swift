//
//  RealmMethods.swift
//  CryptoConverter
//
//  Created by User on 11/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMethods {
    
    static func readQuote(query: String = "") -> [Quote] {
        
        var cachedQuoteArray: [Quote] = []
        do {
            let realm = try Realm()
            let results = realm.objects(QuoteCached.self)
            if query == "" {
                results
                    .map {Quote(quote: $0)}
                    .forEach { quote in
                        cachedQuoteArray.append(quote)
                }
            } else {
                let queryResults = results.filter("name CONTAINS[cd] %@ || symbol CONTAINS[cd] %@", query, query).sorted(byKeyPath: "rank", ascending: true)
                queryResults
                    .map {Quote(quote: $0)}
                    .forEach {quote in
                        cachedQuoteArray.append(quote)
                }
            }
        } catch {
            print("Error reading from Realm database: \(error)")
        }
        return cachedQuoteArray
    }
    
    static func saveQuote(quotes: [Quote]) {
        quotes
            .map {QuoteCached(quote: $0)}
            .forEach { quote in
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(quote, update: .all)
                    }
                } catch {
                    print("Error saving to Realm database: \(error)")
                }
        }
    }
}
