//
//  ContentViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation
import UIKit

class ContentViewModel: ObservableObject {
    
    @Published var alarms: [Alarm] = Storage.shared.alarms
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
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

}
