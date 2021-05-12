//
//  Time.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation

struct Time: Codable, Identifiable {
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
    var id: Date = Date()
}

extension Time {
    func toDateComponents() -> DateComponents {
        return DateComponents(hour: hour, minute: minute)
    }
    static let zero = Time(hour: 0, minute: 0, second: 0)
    
    func inMinutes() -> Int {
        return (hour * 60) + minute
    }
    
    func rangeArray(to time: Time) -> [Int] {
        let first = min(inMinutes(), time.inMinutes())
        let second = max(inMinutes(), time.inMinutes())
        
        return [Int](first...second)
    }
    
    static var endOfDay: Time = Time(hour: 23, minute: 59, second: 59)
    static var startOfDay: Time = Time(hour: 0, minute: 0, second: 0)
}
