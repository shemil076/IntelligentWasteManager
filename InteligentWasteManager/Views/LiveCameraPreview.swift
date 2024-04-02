//
//  LiveCameraPreview.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-26.
//

import SwiftUI
import AVFoundation
import Combine


struct LiveCameraPreview: UIViewControllerRepresentable {
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.setupAVCapture()
        return cameraViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update your UI if necessary
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self , navigationViewModel : navigationViewModel)
    }
    
    class Coordinator: NSObject {
        var parent: LiveCameraPreview
        var timer: Timer?
        var navigationViewModel :NavigationViewModel
        private var cancellables = Set<AnyCancellable>()
        
        init(_ parent: LiveCameraPreview, navigationViewModel : NavigationViewModel) {
            self.parent = parent
            self.navigationViewModel = navigationViewModel
            super.init()
            
            setupTimer()
            
            navigationViewModel.$shouldRestartTimer
                .dropFirst() // Ignore the initial value
                .sink { [weak self] _ in self?.setupTimer() }
                .store(in: &cancellables)
        }
        
        func setupTimer() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.navigationViewModel.showAlert = true
            }
        }
    }
}


struct LiveCameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        LiveCameraPreview(navigationViewModel: NavigationViewModel())
    }
}
