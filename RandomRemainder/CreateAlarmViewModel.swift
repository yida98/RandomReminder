//
//  CreateAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import Foundation

class CreateAlarmViewModel: ObservableObject {
    @Published var title: String = "" {
        willSet {
            if newValue.count >= 1 {
                finished = true
            } else {
                finished = false
            }
        }
    }
    @Published var occurence: Int = 10
    @Published var activeAllDay: Bool = true
    @Published var random: Bool = true
    @Published var duration: [Date] = [Date.toNearestHour(from: Date(), lowerBound: true),
                                       Date.toNearestHour(from: Date(), lowerBound: false)]
    
    @Published var finished: Bool = false
    
    func done(_ completion: @escaping () -> Void) {
        let alarm = Alarm(text: title, duration: activeAllDay ? [Time]() : duration.map { $0.toTime() }, occurence: occurence, randomFrequency: random)
        Storage.shared.addAlarm(alarm: alarm)
        completion()
    }
    
    func addDuration() {
        duration.append(Date.toNearestHour(from: Date(), lowerBound: true))
        duration.append(Date.toNearestHour(from: Date(), lowerBound: false))
    }
}

extension Date {
    func toTime() -> Time {
        let dc = Calendar.current.dateComponents([.hour, .month, .minute], from: self)
        let time = Time(hour: dc.hour ?? 0,
                        minute: dc.minute ?? 0,
                        second: dc.second ?? 0)
        return time
    }
}
