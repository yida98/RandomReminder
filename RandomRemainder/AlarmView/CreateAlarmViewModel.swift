//
//  CreateAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import Foundation
import Combine

class CreateAlarmViewModel: PopoutViewModelParent {
    
    override func done(_ completion: @escaping () -> Void) {
        let alarm = Alarm(text: title,
                          duration: activeAllDay ? [Time]() : duration.flatMap { [$0.0.toTime(), $0.1.toTime()] },
                          occurence: occurence,
                          randomFrequency: random)
        Storage.shared.addAlarm(alarm: alarm)
        completion()
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
