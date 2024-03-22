//
//  CameraViewController.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-22.
//

import SwiftUI
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    lazy var networkManager : NetworkManager = AppDependencyContainer.shared.networkManager
    
    var boundingBoxOverlay : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoundingBoxOverlay()
        setupAVCapture()
        observeDetectionResults()
    }
    
    private func observeDetectionResults(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleDetectionResults(notification:)), name: .didReceiveDetectionResults, object: nil)
        
    }
    
    @objc func handleDetectionResults(notification : Notification){
        guard let userInfo = notification.userInfo,
              let _ = userInfo["detectedObjects"] as? [DetectedObject] else {return}
        
        DispatchQueue.main.async { [weak self] in
            self?.drawBoundingBoxes()
        }
    }

    
    
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
        
        captureSession.startRunning()
        
        setupBoundingBoxOverlay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = self.view.bounds
        boundingBoxOverlay.frame = self.view.bounds
    }
    
    func setupBoundingBoxOverlay(){
        boundingBoxOverlay = UIView(frame: view.bounds)
        boundingBoxOverlay.backgroundColor = .clear
        view.addSubview(boundingBoxOverlay)
        view.bringSubviewToFront(boundingBoxOverlay)
    }
    
    func drawBoundingBoxes(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.boundingBoxOverlay.subviews.forEach { $0.removeFromSuperview() }
            
            let viewSize = self.boundingBoxOverlay.bounds.size
            for detectedObject in self.networkManager.detectedObjectsList {
                let box = detectedObject.box
                let imageSize = CGSize(width: 200, height: 350)
                let rect = self.scaleAndTranslate(box: box, fromImageSize: imageSize, toViewSize: viewSize)
                let boundingBoxView = UIView(frame: rect)
                boundingBoxView.layer.borderColor = UIColor.green.cgColor
                boundingBoxView.layer.borderWidth = 2.0
                self.boundingBoxOverlay.addSubview(boundingBoxView)
            }
        }
    }

    
    func scaleAndTranslate(box: DetectedObject.Box, fromImageSize imageSize: CGSize, toViewSize viewSize: CGSize) -> CGRect {
        // Calculate scale factors
        let scaleX = viewSize.width / imageSize.width
        let scaleY = viewSize.height / imageSize.height
        
        // Scale and translate box coordinates
        let x1 = box.x1 * scaleX
        let y1 = box.y1 * scaleY
        let x2 = box.x2 * scaleX
        let y2 = box.y2 * scaleY
        
        return CGRect(x: x1, y: y1, width: x2 - x1, height: y2 - y1)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession?.stopRunning()
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate method
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let cvPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: cvPixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return } // Compress to reduce size
        
        // Send the frame over WebSocket
        print()
        networkManager.sendFrame(imageData)
    }
    
    // Remove the view controller as an observer when it's being deallocated
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

