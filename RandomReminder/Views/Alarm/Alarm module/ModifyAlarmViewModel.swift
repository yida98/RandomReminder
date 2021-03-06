//
//  ModifyAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-08.
//

import Foundation
import Combine

class ModifyAlarmViewModel: PopoutViewModel {
    
    private var id: UUID?
    
    init(alarm: Alarm) {
        super.init()
        self.title = alarm.text
        self.occurence = alarm.occurence
        self.activeAllDay = alarm.duration.isEmpty
        self.random = alarm.randomFrequency
        if !alarm.duration.isEmpty {
            self.duration = try! alarm.duration.map { $0.toDate() }.toTuple()
            self.durationIndices = [Int](self.duration.indices)
        }
        self.id = alarm.id
    }
    
    override func done(_ completion: @escaping (Alarm) -> Void) {
        super.done { alarm in
            Storage.shared.updateAlarm(alarm, for: self.id!)
            completion(alarm)
        }
    }
    
}

extension Time {
    func toDate() -> Date {
        let dc = self.toDateComponents()
        let date = Calendar.current.date(from: dc)
        return date!
    }
}
