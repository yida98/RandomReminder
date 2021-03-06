//
//  LocalNotificationManager.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-10.
//

import Foundation
import UserNotifications

class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    private static let notificationSound = UNNotificationSound.default
    static let shared = LocalNotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    static func requestNotificationPermission(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            completion(success, error)
        }
    }
    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
    }
    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo) // the payload that is attached to the push notification
        // you can customize the notification presentation options. Below code will show notification banner as well as play a sound. If you want to add a badge too, add .badge in the array.
        LocalNotificationManager.shared.removeAllNotifications(with: [notification.request.identifier])
        Logger.log(.notificationReceived, message: notification.debugDescription)
        if let requestAlarm = Alarm.getAlarm(from: notification.request.identifier) {
            if let occurenceNumber = Alarm.getOccurence(from: notification.request.identifier) {
                let newDateComponents = requestAlarm.executionTimes()[occurenceNumber].toDateComponents()
                let newTrigger = UNCalendarNotificationTrigger(dateMatching: newDateComponents, repeats: true)
                LocalNotificationManager.shared.addNotification(alarm: requestAlarm, trigger: newTrigger, notificationId: notification.request.identifier)
                completionHandler([.banner, .sound])
            }
        }

    }
    
}

extension LocalNotificationManager {
    
    private func addNotification(alarm: Alarm, trigger: UNNotificationTrigger, notificationId: String) {
        let content = LocalNotificationManager.contentBuilder(alarm: alarm)
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        sendNotification(with: request)
    }
    
    func addNotification(alarm: Alarm) {
        let content = LocalNotificationManager.contentBuilder(alarm: alarm)
        let idStrings = LocalNotificationManager.generateNotificationId(forAlarm: alarm)
        for occurence in 0..<alarm.occurence {
            let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: alarm.executionTimes()[occurence].toDateComponents(), repeats: true)
//            debugPrint(alarm.executionTimes()[occurence].toDateComponents().debugDescription)
            let request = UNNotificationRequest(identifier: idStrings[occurence], content: content, trigger: calendarTrigger)
            sendNotification(with: request)
        }
    }
    
    private static func contentBuilder(alarm: Alarm) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
//        content.title = alarm.text
        content.body = alarm.text
        content.sound = LocalNotificationManager.notificationSound
        return content
        
    }
    
    private func sendNotification(with request: UNNotificationRequest) {
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
             if let theError = error {
                 // Handle any errors
                Logger.log(.error, message: theError.localizedDescription)
             } else {
                Logger.log(.notificationSent, message: request.debugDescription)
             }
        }
    }
    
}

extension LocalNotificationManager {
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func removeAllNotifications(with identifiers: [String]) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiers)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

extension LocalNotificationManager {
    
    func snoozeAlarm(for alarm: Alarm) {
        let identifiers = LocalNotificationManager.generateNotificationId(forAlarm: alarm)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    static func generateNotificationId(forAlarm: Alarm) -> [String] {
        var result = [String]()
        for occurence in 0..<forAlarm.occurence {
            let id = forAlarm.notificationIdString(with: String(occurence))
            result.append(id)
        }
        return result
    }
    
    static func generateNotificationId(forId: UUID) -> [String] {
        if let alarm = Storage.shared.alarms.first(where: { $0.id == forId }) {
            return generateNotificationId(forAlarm: alarm)
        }
        return [String]()
    }
}
