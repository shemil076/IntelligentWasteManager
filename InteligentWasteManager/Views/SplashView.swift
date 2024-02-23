//
//  SplashView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-23.
//

import SwiftUI

struct SplashScreenView: View {
    // This binding variable will control the navigation to the main content
    @Binding var isActive: Bool

    var body: some View {
        VStack {
            // Your splash screen content here
            Text("Welcome to My App")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .onAppear {
            // Start a timer to transition to the main content after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
