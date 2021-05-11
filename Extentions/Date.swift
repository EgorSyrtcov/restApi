//
//  Date.swift
//  Rest API
//
//  Created by Egor Syrtcov on 5/11/21.
//

import Foundation

extension Date {
    static func convertDataFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
