//
//  Date+Ext.swift
//  RandomReminder
//
//  Created by Yida Zhang on 2021-05-21.
//

import Foundation

extension Date {
    func toTime() -> Time {
        let dc = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        let time = Time(hour: dc.hour ?? 0,
                        minute: dc.minute ?? 0,
                        second: dc.second ?? 0)
        return time
    }
    
    func toDateComponents() -> DateComponents {
        let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: self)
        let dc = DateComponents(day: calendar.day ?? 0,
                                hour: calendar.hour ?? 0,
                                minute: calendar.minute ?? 0,
                                second: calendar.second ?? 0)
        return dc
    }
    
    static func toNearestHour(from date: Date, lowerBound: Bool) -> Date {
        var dateComponent = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
        dateComponent.minute = 0
        if !lowerBound {
            if dateComponent.hour == 23 {
                dateComponent.minute = 59
            } else {
                dateComponent.hour = dateComponent.hour!.advanced(by: 1)
            }
        }
        let newDate = Calendar.current.date(from: dateComponent)
        return newDate!
    }

}
