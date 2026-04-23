// Services/NotificationManager.swift

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()

    private init() {}

    // MARK: - Request Permission

    /// Requests authorization for alerts, sounds, and badges.
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("[Notification] Authorization error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    // MARK: - Gear Check Reminder

    /// Fires a local notification immediately reminding the hiker to check their gear.
    /// Called when the step count in the last 3 hours is below the threshold,
    /// implying the user is resting at a campsite or rest stop.
    func sendGearCheckReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Waktunya Cek Barang!"
        content.body = "Kamu sepertinya sedang beristirahat. Pastikan tidak ada barang bawaan yang tertinggal sebelum melanjutkan perjalanan ya!"
        content.sound = .default

        // trigger = nil means fire immediately; timeInterval of 1 second
        // is the minimum for a UNTimeIntervalNotificationTrigger.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: "gearCheckReminder-\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let error = error {
                print("[Notification] Failed to schedule: \(error.localizedDescription)")
            } else {
                print("[Notification] Gear check reminder scheduled.")
            }
        }
    }
}
