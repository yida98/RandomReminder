//
//  Time.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation

struct Time: Codable, Identifiable {
    var hour: Int
    var minute: Int
    var second: Int
    var id: Date = Date()
    
    init(hour: Int = 0, minute: Int = 0, second: Int = 0, id: Date = Date()) {
        let extraMinutes = Int(second / 60)
        self.second = second % 60
        let extraHours = Int(minute / 60)
        self.minute = (minute % 60) + extraMinutes
        self.hour = hour + extraHours
        self.id = id
    }
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
    
    func randomTime(in minuteRange: Range<Int>) -> Int {
        return Int.random(in: minuteRange)
    }
    
    mutating func incrementBy(minutes: Int) {
        let hours = Int(minutes/60)
        hour += hours
        minute += minutes%60
    }
    
    static var endOfDay: Time = Time(hour: 23, minute: 59, second: 59)
    static var startOfDay: Time = Time(hour: 0, minute: 0, second: 0)
}
