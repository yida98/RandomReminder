//
//  ModifyAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-08.
//

import Foundation

class ModifyAlarmViewModel: PopoutViewModel {
    var title: String {
        willSet {
            if newValue.count >= 1 {
                finished = true
            } else {
                finished = false
            }
        }
    }
    @Published var occurence: Int
    @Published var activeAllDay: Bool
    @Published var random: Bool
    @Published var duration: [Date]
    @Published var finished: Bool = true
    private var id: UUID
    
    init(alarm: Alarm) {
        self.title = alarm.text
        self.occurence = alarm.occurence
        self.activeAllDay = alarm.duration.isEmpty
        self.random = alarm.randomFrequency
        self.duration = alarm.duration.map { $0.toDate() }
        if alarm.duration.isEmpty {
            print("is empty")
            self.duration = Constants.defaultDates
        }
        self.id = alarm.id
    }
    
    func done(_ completion: @escaping () -> Void) {
        let alarm = Alarm(text: title, duration: activeAllDay ? [Time]() : duration.map { $0.toTime() }, occurence: occurence, randomFrequency: random)
        Storage.shared.updateAlarm(alarm, for: id)
        completion()
    }
    
    func addDuration() {
        duration.append(contentsOf: Constants.defaultDates)
    }
}

extension Time {
    func toDate() -> Date {
        let dc = self.toDateComponents()
        let date = Calendar.current.date(bySettingHour: dc.hour ?? 0,
                                              minute: dc.minute ?? 0,
                                              second: dc.second ?? 0,
                                              of: self.id)
        return date!
    }
}
