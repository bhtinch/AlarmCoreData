//
//  NotificationScheduler.swift
//  AlarmCoreData
//
//  Created by Benjamin Tincher on 1/21/21.
//

import UserNotifications

protocol NotificationScheduler {
//    func scheduleUserNotificaitonsFor(alarm: Alarm)
//    func cancelUserNotificationsFor(alarm: Alarm)
}

extension NotificationScheduler {
    func scheduleUserNotificationsFor(alarm: Alarm) {
        guard let fireDate = alarm.fireDate,
              let id = alarm.uuidString else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Ding Ding Ding"
        content.body = "The time is now for your alarm: \(alarm.title ?? "user set alarm")"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotificationsFor(alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
