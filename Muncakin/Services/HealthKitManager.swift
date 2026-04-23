// Services/HealthKitManager.swift

import Combine
import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()

    @Published var todaySteps: Double = 0.0

    private init() {}

    // MARK: - Authorization

    /// Requests read-only access to HealthKit step count data.
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }

        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }

        healthStore.requestAuthorization(toShare: nil, read: [stepType]) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }

    // MARK: - Fetch Today's Steps

    /// Fetches cumulative step count from midnight to now, updating `todaySteps`.
    func fetchTodaySteps() {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        fetchSteps(from: startOfDay, to: now) { [weak self] steps in
            self?.todaySteps = steps
        }
    }

    // MARK: - Fetch Steps in Range

    /// Fetches cumulative step count between two dates using `HKStatisticsQuery`.
    /// Completion is called on the main queue.
    func fetchSteps(from startDate: Date, to endDate: Date, completion: @escaping (Double) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0)
            return
        }

        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )

        let query = HKStatisticsQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            let steps = result?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
            DispatchQueue.main.async {
                completion(steps)
            }
        }

        healthStore.execute(query)
    }

    // MARK: - Background Observer

    /// Enables HealthKit background delivery and starts an observer query
    /// so the app is woken when new step data arrives.
    func startObservingSteps() {
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }

        healthStore.enableBackgroundDelivery(for: stepType, frequency: .hourly) { success, error in
            if success {
                print("[HealthKit] Background delivery aktif.")
            } else {
                print("[HealthKit] Gagal mengaktifkan background delivery: \(error?.localizedDescription ?? "")")
            }
        }

        let query = HKObserverQuery(sampleType: stepType, predicate: nil) { [weak self] _, completionHandler, error in
            if let error = error {
                print("[HealthKit] Observer error: \(error.localizedDescription)")
                completionHandler()
                return
            }
            self?.fetchTodaySteps()
            completionHandler()
        }

        healthStore.execute(query)
    }
}
