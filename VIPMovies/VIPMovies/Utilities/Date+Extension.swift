//
//  Date+Extension.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

extension Date {

    static var dateFormat = "yyyy"

    func yearAgoSinceDate() -> String? {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            return "Last year"
        }
        return nil
    }
}
