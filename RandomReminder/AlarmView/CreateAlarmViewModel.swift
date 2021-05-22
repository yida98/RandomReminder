//
//  CreateAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import Foundation
import Combine

class CreateAlarmViewModel: PopoutViewModel {
    
    override func done(_ completion: @escaping (Alarm) -> Void) {
        super.done { alarm in
            Storage.shared.addAlarm(alarm: alarm)
            completion(alarm)
        }
    }
}

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
}
