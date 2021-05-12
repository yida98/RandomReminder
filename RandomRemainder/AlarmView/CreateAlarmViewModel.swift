//
//  CreateAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import Foundation

protocol PopoutViewModel: ObservableObject {
    var title: String { get set }
    var occurence: Int { get set }
    var activeAllDay: Bool { get set }
    var random: Bool { get set }
    var duration: [Date] { get set }
    var finished: Bool { get set }
    
    func done(_ completion: @escaping () -> Void)
    func addDuration()
}

class CreateAlarmViewModel: PopoutViewModel {
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
    @Published var duration: [Date] = Constants.defaultDates
    
    @Published var finished: Bool = false
    
    func done(_ completion: @escaping () -> Void) {
        let alarm = Alarm(text: title, duration: activeAllDay ? [Time]() : duration.map { $0.toTime() }, occurence: occurence, randomFrequency: random)
        Storage.shared.addAlarm(alarm: alarm)
        completion()
    }
    
    func addDuration() {
        duration.append(contentsOf: Constants.defaultDates)
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
