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
    
    func addNotification(alarm: Alarm) {
        for occurence in 0..<alarm.occurence {
            let content = UNMutableNotificationContent()
            content.title = alarm.text
            content.body = alarm.text
            content.sound = LocalNotificationManager.notificationSound
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    //            let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
            
            let request = UNNotificationRequest(identifier: alarm.notificationIdString(with: String(occurence)), content: content, trigger: trigger) // Schedule the notification.
            sendNotification(with: request)
        }
        
    }
    
    private func sendNotification(with request: UNNotificationRequest) {
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
             if let theError = error {
                 // Handle any errors
                print(theError)
             }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo) // the payload that is attached to the push notification
        // you can customize the notification presentation options. Below code will show notification banner as well as play a sound. If you want to add a badge too, add .badge in the array.
        print(notification.request)
        completionHandler([.banner, .sound])

    }
}
