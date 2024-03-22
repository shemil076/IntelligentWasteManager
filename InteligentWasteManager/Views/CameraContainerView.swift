//
//  CameraContainerView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-11.
//

import SwiftUI

struct CameraContainerView: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LiveCameraPreview(navigationViewModel: navigationViewModel).ignoresSafeArea()
                    .alert(isPresented: $navigationViewModel.showAlert) {
                        Alert(title: Text("Scanning for 5 seconds"),
                              message: Text("Do you want to wait or go ahead?"),
                              primaryButton: .default(Text("Wait")),
                              secondaryButton: .default(Text("Go Ahead")) {
                            navigationViewModel.navigate = true
                              })
                    }
                
                NavigationLink(destination: IdentifiedWasteItemsView(), isActive: $navigationViewModel.navigate) {
                    EmptyView()
                }
            }
        }
    }
}


#Preview {
    CameraContainerView()
}
