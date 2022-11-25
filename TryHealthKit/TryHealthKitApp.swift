//
//  TryHealthKitApp.swift
//  TryHealthKit
//
//  Created by Jonathan Ricky Sandjaja on 07/10/22.
//

import SwiftUI

@main
struct TryHealthKitApp: App {
    var healthVM = HealthKitViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthVM)
        }
    }
}
