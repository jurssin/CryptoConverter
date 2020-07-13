//
//  Formatter.swift
//  lesson3
//
//  Created by User on 11/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class Formatter {
    private init() {
        
    }
    
    static func dataFormatter (_ data: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-YYYY, HH:mm:ss"
        
        let formattedDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(data)))
        
        return formattedDate
    }
    
    static func numberFormatter (_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let formattedNumber = formatter.string(from: NSNumber(value: Int(number)))
        
        
        return formattedNumber ?? "error formatting"
    }
}
