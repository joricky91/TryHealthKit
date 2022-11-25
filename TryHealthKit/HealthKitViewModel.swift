//
//  HealthKitViewModel.swift
//  TryHealthKit
//
//  Created by Jonathan Ricky Sandjaja on 07/10/22.
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    
    var healthStore = HKHealthStore()
    var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    var isAuthorized = false
    
    init() {
        changeAuthorizationStatus()
    }
    
    //MARK: - HealthKit Authorization Request Method
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }
    
    //MARK: - Read User's Step Count
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step == 0.0 {
                return
            } else {
                DispatchQueue.main.async {
                    return self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
}
