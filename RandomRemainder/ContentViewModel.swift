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
    
    @Published var alarms: [Alarm] = Storage.shared.alarms
    @Published var location: CGPoint = CGPoint(x: 0, y: 0)
    @Published var difference: CGFloat?
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
    
    var scale: CGFloat {
        var scale: CGFloat = 0
        let difference = (location.y - Constants.scrollViewOffset)
        if difference > 0 && difference <= 120 {
            scale = (120 - difference)/120
        }
        return scale
    }
    
    func deleteAlarm(offsets: IndexSet) {
        let objects = offsets.map { Storage.shared.alarms[$0] }
        Storage.shared.alarms = Storage.shared.alarms.filter { object in
            !objects.contains { alarm in
                return object.id == alarm.id
            }
        }
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
    }
    
    func addAlarm() {
        
    }

}
