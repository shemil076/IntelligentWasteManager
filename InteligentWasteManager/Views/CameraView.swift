//
//  CameraView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-24.
//

import SwiftUI

import SwiftUI
//import AVFoundation
//
//
//struct LiveCameraPreview: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = .camera
//        picker.showsCameraControls = true // Optional: Display camera controls
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//       // No updates needed for a simple live preview
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: LiveCameraPreview
//
//        init(parent: LiveCameraPreview) {
//            self.parent = parent
//        }
//
//        // Add more functionality if needed, such as:
//        // - imagePickerController(_:didFinishPickingMediaWithInfo:) to process captured images
//    }
//}

#Preview {
    CameraView()
}
