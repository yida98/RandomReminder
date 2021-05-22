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
