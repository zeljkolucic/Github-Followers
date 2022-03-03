//
//  Date+.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
