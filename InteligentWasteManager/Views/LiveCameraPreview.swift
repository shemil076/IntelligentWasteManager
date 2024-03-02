//
//  LiveCameraPreview.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-26.
//

import SwiftUI
import AVFoundation
import Starscream

struct LiveCameraPreview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.setupAVCapture()
        return cameraViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update your UI if necessary
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: LiveCameraPreview
        
        init(_ parent: LiveCameraPreview) {
            self.parent = parent
        }
    }
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let networkManager = NetworkManager() // Instance to manage WebSocket connection
    
    func setupAVCapture() {
        
        print("running 44")
        self.captureSession = AVCaptureSession()
        
        guard let captureSession = self.captureSession else { return }
        captureSession.sessionPreset = .medium // Changed to medium for better performance over network
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: backCamera) else {
            print("Unable to access back camera!")
            return
        }
        
        if captureSession.canAddInput(input) { captureSession.addInput(input) }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(videoOutput) { captureSession.addOutput(videoOutput) }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(videoPreviewLayer!)
        print("running 65")
        captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = self.view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession?.stopRunning()
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate method
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("running 81")
        guard let cvPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: cvPixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return } // Compress to reduce size
        print("running 89")
        // Send the frame over WebSocket
        networkManager.sendFrame(imageData)
        print("running 92")
    }
}

// NetworkManager class needs a method to send frames
//extension NetworkManager {
//    func sendFrame(_ imageData: Data) {
//        socket?.write(data: imageData)
//    }
//}


struct LiveCameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        LiveCameraPreview()
    }
}
