//
//  Alarm.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-02.
//

import Foundation
import CoreData

class Alarm: Identifiable, Codable, ObservableObject {
    var text: String
    var id: UUID
    var duration: [Time]
    var occurence: Int
    var randomFrequency: Bool
    
    init(text: String, duration: [Time] = [], occurence: Int = 3, randomFrequency: Bool = true) {
        self.id = UUID()
        self.text = text
        self.duration = duration
        self.occurence = occurence
        self.randomFrequency = randomFrequency
    }
    
}

extension Alarm {
    func descriptionBuilder() -> String {
        // Randomly occuring all-day
        // Occuring from 9am to 10am and 12pm to 2pm
        var result = [String]()
        if randomFrequency {
            result.append("Randomly")
        }
        result.append("occuring")
        if duration.isEmpty {
            result.append("all-day")
        } else {
            result.append("from")
            
            var i = 0
            var j = 1
            while j < duration.count {
                result.append(Alarm.timeFormatter.string(from: duration[i].toDateComponents()) ?? "")
                result.append("to")
                result.append(Alarm.timeFormatter.string(from: duration[j].toDateComponents()) ?? "")
                if j < (duration.count - 1) {
                    result.append("and")
                }
                i += 2
                j = i + 1
            }
        }
        
        var resultString = result.joined(separator: " ")
        return resultString.captalized()
    }
    
    private static var timeFormatter: DateComponentsFormatter {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.hour, .minute]
        return dateComponentsFormatter
    }
    
    func notificationIdString(with suffix: String = "") -> String {
        return self.id.uuidString + suffix
    }
    
    static func getAlarm(with notificationString: String) -> Alarm? {
        
        let result = Storage.shared.alarms.first { notificationString.hasPrefix($0.notificationIdString()) }
        
        return result
    }
    
    func totalMinutesADay() -> Int {
        if duration.isEmpty {
            return 60 * 24
        }
        
        var total = 0
        var i = 1
        
        while i < duration.count {
            total += duration[i].inMinutes() - duration[i - 1].inMinutes()
            i += 2
        }
        
        return total
    }
    
    func minutesRange() -> [Int] {
        var result = [Int]()
        var i = 1
        while i < duration.count {
            result.append(contentsOf: duration[i].rangeArray(to: duration[i - 1]))
            i += 2
        }
        return result
    }
    
    func executionTimes() {
        var result = [Time]()
        var elapsingMinutes = Int(totalMinutesADay() / occurence)
        var range = minutesRange()
        if duration.isEmpty {
            range = [Int](0...Time.endOfDay.inMinutes())
        }
        
        for i in 0..<occurence {
            
        }
        
    }
}
