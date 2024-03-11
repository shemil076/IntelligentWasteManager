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
    
    var networkManager = NetworkManager()

     var body: some Scene {
         WindowGroup {
             if isActive {
                 ContentView().environmentObject(networkManager).environmentObject(AppDependencyContainer.shared.wasteItemViewModel)
             } else {
                 SplashScreenView(isActive: $isActive)
             }
         }
     }
}
