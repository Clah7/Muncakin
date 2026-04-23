// Services/BackgroundTaskManager.swift

import Foundation
import BackgroundTasks

/// Manages the BGAppRefreshTask that periodically checks step count
/// and triggers a gear-check notification when the hiker appears to be resting.
///
/// ## How iOS Background Tasks Work
/// `BGAppRefreshTask` uses `earliestBeginDate` as a *hint*, not a guarantee.
/// iOS batches background work based on battery level, connectivity, and user
/// behavior patterns. A 3-hour `earliestBeginDate` may actually fire anywhere
/// from 3–6+ hours later — or not at all if the device is in Low Power Mode.
/// This is by design: the system optimizes for battery life over strict timing.
class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()

    /// The identifier registered in Info.plist under BGTaskSchedulerPermittedIdentifiers.
    static let stepCheckTaskID = "com.muncakin.stepCheck"

    /// Steps below this threshold in the rolling window imply the hiker is resting.
    private let stepThreshold: Double = 300

    /// Rolling window duration: 3 hours.
    private let windowInterval: TimeInterval = 3 * 60 * 60

    private init() {}

    // MARK: - Registration

    /// Must be called once during app launch (before `applicationDidFinishLaunching` returns).
    /// Registers the handler that iOS invokes when the system decides to run the task.
    func registerTask() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: Self.stepCheckTaskID,
            using: nil
        ) { task in
            guard let refreshTask = task as? BGAppRefreshTask else { return }
            self.handleStepCheck(task: refreshTask)
        }
        print("[BGTask] Registered \(Self.stepCheckTaskID)")
    }

    // MARK: - Scheduling

    /// Submits a request for the system to launch the app in the background.
    /// `earliestBeginDate` is set to 3 hours from now — the actual execution
    /// time is determined by the system and may be later.
    func scheduleNextStepCheck() {
        let request = BGAppRefreshTaskRequest(identifier: Self.stepCheckTaskID)
        request.earliestBeginDate = Date().addingTimeInterval(windowInterval)

        do {
            try BGTaskScheduler.shared.submit(request)
            print("[BGTask] Scheduled next step check for ~3h from now.")
        } catch {
            print("[BGTask] Scheduling failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Task Handler

    /// The handler invoked by the system when the background task fires.
    ///
    /// Flow:
    /// 1. Immediately schedule the NEXT task (so the chain continues).
    /// 2. Query HealthKit for steps in the last 3 hours.
    /// 3. If steps < 300, fire a gear-check notification.
    /// 4. Mark the task as completed.
    private func handleStepCheck(task: BGAppRefreshTask) {
        // 1. Schedule the next occurrence immediately so the chain never breaks,
        //    even if this handler crashes or times out.
        scheduleNextStepCheck()

        // 2. Set up an expiration handler. If the system kills this task before
        //    completion, we still mark it so iOS doesn't penalize future scheduling.
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }

        // 3. Query HealthKit: steps from (now - 3h) to now.
        let now = Date()
        let threeHoursAgo = now.addingTimeInterval(-windowInterval)

        HealthKitManager.shared.fetchSteps(from: threeHoursAgo, to: now) { [weak self] steps in
            guard let self else {
                task.setTaskCompleted(success: false)
                return
            }

            print("[BGTask] Steps in last 3h: \(steps)")

            // 4. If the hiker has taken very few steps, they're likely resting —
            //    send a reminder to check their gear before leaving.
            if steps < self.stepThreshold {
                NotificationManager.shared.sendGearCheckReminder()
            }

            task.setTaskCompleted(success: true)
        }
    }
}
