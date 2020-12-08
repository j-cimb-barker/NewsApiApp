//
//  Date+ISO8601.swift
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//

import Foundation

extension Date {
    
    public static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: string)
    }
}
