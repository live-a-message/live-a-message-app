//
//  MessageNotificationManager.swift
//  Akee
//
//  Created by Tales Conrado on 14/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UserNotifications
import DesignSystem
import UIKit

class MessageNotificationManager {
    // Singleton
    static var shared = MessageNotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()
    private let options: UNAuthorizationOptions = [.alert, .badge]

    private init() { }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: options) { didAllow, error in
            if error != nil {
                print("Error requesting authorization.")
            }

            if didAllow {
                print("Allowed notifications.")
            }
        }
    }

    func areNotificationsAllowed(completion: @escaping ((Bool) -> Void)) {
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                completion(true)
            }
            completion(false)
        }
    }

    func createNotification(title: String, body: String, badgeNumber: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(
            identifier: "New close message in the area",
            content: content,
            trigger: trigger
        )

        scheduleRequest(request: request)

        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = badgeNumber
        }
    }

    private func scheduleRequest(request: UNNotificationRequest) {
        notificationCenter.add(request) { error in
            if error != nil {
                print("Error adding notification request.")
            }
        }
    }
}
