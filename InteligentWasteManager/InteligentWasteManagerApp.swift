//
//  InteligentWasteManagerApp.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-22.
//

import SwiftUI

@main
struct InteligentWasteManagerApp: App {
    @State private var isActive: Bool = false
    
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
                    .environmentObject(AppDependencyContainer.shared.networkManager).environmentObject(AppDependencyContainer.shared.wasteItemViewModel)
            } else {
                SplashScreenView(isActive: $isActive)
            }
        }
    }
}
