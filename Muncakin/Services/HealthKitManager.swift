//
//  HealthKitManager.swift
//  Muncakin
//
//  Created by Darren Christian Liharja on 23/04/26.
//

import Foundation
import HealthKit
import Combine

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()
    
    @Published var todaySteps: Double = 0.0
    
    private init() {}
    
    // MARK: - 1. Meminta Izin Akses
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        
        healthStore.requestAuthorization(toShare: nil, read: [stepType]) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
    
    // MARK: - 2. Mengambil Data Langkah Hari Ini
    func fetchTodaySteps() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                print("Gagal mengambil data langkah atau data masih kosong: \(error?.localizedDescription ?? "")")
                return
            }
            
            let steps = sum.doubleValue(for: HKUnit.count())
            
            DispatchQueue.main.async {
                self.todaySteps = steps
                print("Total langkah hari ini: \(steps)")
            }
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - 3. Observer Background (Untuk Pengingat)
    func startObservingSteps() {
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        
        healthStore.enableBackgroundDelivery(for: stepType, frequency: .hourly) { success, error in
            if success {
                print("Background delivery untuk langkah kaki aktif.")
            } else {
                print("Gagal mengaktifkan background delivery: \(error?.localizedDescription ?? "")")
            }
        }
        
        let query = HKObserverQuery(sampleType: stepType, predicate: nil) { [weak self] _, completionHandler, error in
            if let error = error {
                print("Observer Error: \(error.localizedDescription)")
                return
            }
            
            self?.fetchTodaySteps()
            
            completionHandler()
        }
        
        healthStore.execute(query)
    }
}
