//
//  ContentViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation
import UIKit
import SwiftUI

class ContentViewModel: ObservableObject {

    @Published var location: CGPoint = CGPoint(x: 0, y: 0)
    @Published var isReady: Bool = false {
        willSet {
            if newValue == true  {
                Constants.hapticFeedback(.medium)
            }
        }
    }
    
    @Published var isAdding: Bool = false
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
    }
    
    var scale: CGFloat {
        var scale: CGFloat = 0
        let difference = (location.y - Constants.scrollViewOffset)
        if difference > 0 && difference <= 120 {
            scale = (120 - difference)/120
        }
        return scale
    }
    
//    func deleteAlarm(offsets: IndexSet) {
//        let objects = offsets.map { Storage.shared.alarms[$0] }
//        Storage.shared.alarms = Storage.shared.alarms.filter { object in
//            !objects.contains { alarm in
//                return object.id == alarm.id
//            }
//        }
//    }
    
    func addAlarm() {
        
//        let newAlarm = Alarm(text: "Whaaps")
//        Storage.shared.addAlarm(alarm: newAlarm)
    }

}
