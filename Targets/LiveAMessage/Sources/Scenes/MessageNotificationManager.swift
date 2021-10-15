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
import CloudKit

class MessageNotificationManager {
    // Singleton
    static let shared = MessageNotificationManager()

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
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
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

    func subscribeForRemoteNotifications() {
        let subscription = CKQuerySubscription(
            recordType: "Notifications",
            predicate: NSPredicate(format: "TRUEPREDICATE"),
            options: .firesOnRecordCreation
        )

        let info = CKSubscription.NotificationInfo()

        info.titleLocalizationKey = "%1$@"
        info.titleLocalizationArgs = ["title"]

        info.alertLocalizationKey = "%1$@"
        info.alertLocalizationArgs = ["content"]

        info.shouldBadge = true

        info.soundName = "default"

        subscription.notificationInfo = info

        CKContainer.default().publicCloudDatabase.save(subscription) { _, error in
            if error == nil {
                print("Succefully subscribed to push notifications.")
            } else {
                print("Error: Failed to subscribe to push notifications.")
            }
        }
    }
}
