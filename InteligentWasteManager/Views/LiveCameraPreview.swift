//
//  LiveCameraPreview.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-26.
//

import SwiftUI
import AVFoundation
import Vision

struct LiveCameraPreview: UIViewControllerRepresentable {
    private var model: VNCoreMLModel?
    
    init() {
        // Load the ML model
        do {
            let configuration = MLModelConfiguration()
            let modelContainer = try best1(configuration: configuration) // Use your model's specific initializer
            self.model = try VNCoreMLModel(for: modelContainer.model)
        } catch {
            print("Failed to load the model: \(error)")
        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.setupAVCapture(model: model)
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
    var detectionRequest: VNCoreMLRequest?
    var overlayView: UIView!
    
    func setupAVCapture(model: VNCoreMLModel?) {
        self.captureSession = AVCaptureSession()
        
        guard let captureSession = self.captureSession, let model = model else { return }
        captureSession.sessionPreset = .photo
        
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
        
        // Setup overlay view for bounding boxes
        overlayView = UIView()
        overlayView.frame = self.view.bounds
        overlayView.backgroundColor = .clear
        overlayView.isUserInteractionEnabled = false
        self.view.addSubview(overlayView)
        
        detectionRequest = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            self?.processDetections(for: request, error: error)
        })
        
        captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = self.view.bounds
        overlayView.frame = self.view.bounds // Ensure the overlay view matches the video layer size
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        do {
            try imageRequestHandler.perform([detectionRequest!])
        } catch {
            print(error)
        }
    }
    
    private func processDetections(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            self.overlayView.layer.sublayers?.removeAll(where: { $0 is CAShapeLayer })
            guard let results = request.results as? [VNRecognizedObjectObservation] else { return }
            
            for detection in results {
                let boundingBox = self.transformBoundingBox(detection.boundingBox)
                self.drawBoundingBox(boundingBox)
                
                // Filter labels with confidence greater than 0.60
                let highConfidenceLabels = detection.labels.filter { $0.confidence > 0.60 }
                
                // Map filtered labels to string
                let topLabels = highConfidenceLabels.map { label in
                    return "\(label.identifier): \(String(format: "%.2f", label.confidence))"
                }.joined(separator: ", ")
                
                // Print only if there are labels meeting the criteria
                if !topLabels.isEmpty {
                    print("Detected: \(topLabels)")
                    print("===========================>>")
                }
            }
        }
    }

    
    private func transformBoundingBox(_ boundingBox: CGRect) -> CGRect {
        let x = boundingBox.minX * overlayView.bounds.width
        let y = (1 - boundingBox.maxY) * overlayView.bounds.height // Invert y-axis
        let width = boundingBox.width * overlayView.bounds.width
        let height = boundingBox.height * overlayView.bounds.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func drawBoundingBox(_ rect: CGRect) {
        let boundingBoxLayer = CAShapeLayer()
        boundingBoxLayer.frame = rect
        boundingBoxLayer.cornerRadius = 3
        boundingBoxLayer.borderWidth = 2
        boundingBoxLayer.borderColor = UIColor.red.cgColor
        boundingBoxLayer.backgroundColor = UIColor.clear.cgColor
        overlayView.layer.addSublayer(boundingBoxLayer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession?.stopRunning()
    }
}

struct LiveCameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        LiveCameraPreview()
    }
}
