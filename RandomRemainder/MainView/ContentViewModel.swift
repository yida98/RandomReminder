//
//  ContentViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation
import UIKit
import SwiftUI
import UserNotifications
import Combine

class ContentViewModel: ObservableObject {

    @Published var location: CGPoint = CGPoint(x: 0, y: 0)
    @Published var isReady: Bool = false {
        willSet {
            if newValue == true  {
                Constants.hapticFeedback(.medium)
            }
        }
    }
    
    @Published var isPresenting: Bool = false
    @Published var adding: Bool = true
    @Published var allowsNotification: Bool = true
    
    var tappedAlarm: Alarm? {
        willSet {
            if newValue != nil {
                adding = false
                isPresenting = true
            }
        }
    }
    
    init() {
        UISetup()
        LocalNotificationManager.requestNotificationPermission { success, error in
            if success {
                Just(success)
                    .receive(on: RunLoop.main)
                    .assign(to: &self.$allowsNotification)
            } else {
                LocalNotificationManager.shared.removeAllNotifications()
                LocalNotificationManager.shared.removeAllNotifications(with: ["AFA2C350-F0DE-4513-AFE5-272D811EB8F7"])
            }
        }
    }
    
    private func UISetup() {
        UIView.appearance().overrideUserInterfaceStyle = .light
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { value in
            print("Open Settings")
        }
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
