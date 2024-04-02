//
//  VideoUploaderView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-04-02.
//

import SwiftUI
import AVFoundation

struct VideoUploaderView: View {
    @State private var videoURL: URL?
    @State private var isVideoPickerDisplayed = false
    var networkManager : NetworkManager = AppDependencyContainer.shared.networkManager
    
    var body: some View {
        VStack {
            Button("Select Video") {
                isVideoPickerDisplayed = true
            }
        }
        .sheet(isPresented: $isVideoPickerDisplayed) {
            VideoPicker(videoURL: $videoURL)
        }
        .onChange(of: videoURL) { _ in
            processAndSendVideo()
        }
    }

    func processAndSendVideo() {
        guard let videoURL = videoURL else { return }
        // Extract frames and send to server
        extractFramesAndSend(videoURL: videoURL)
    }
    
    

    func extractFramesAndSend(videoURL: URL) {
        let asset = AVAsset(url: videoURL)
        let durationInSeconds = CMTimeGetSeconds(asset.duration)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true

        // Decide on the frame extraction frequency (e.g., one frame per second)
        let frameExtractionInterval = 1.0 // seconds
        let times = stride(from: 0.0, to: durationInSeconds, by: frameExtractionInterval).map {
            CMTimeMakeWithSeconds($0, preferredTimescale: 600)
        }

        // Use a DispatchGroup if you want to know when all frames have been processed
        let dispatchGroup = DispatchGroup()

        for time in times {
            dispatchGroup.enter() // Indicate we are adding a task to the group
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
                    let uiImage = UIImage(cgImage: cgImage)
                    if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                        DispatchQueue.main.async {
                            self.networkManager.sendFrame(imageData)
                            dispatchGroup.leave() // Indicate task finished
                        }
                    } else {
                        dispatchGroup.leave() // Ensure leave is called even if imageData is nil
                    }
                } catch {
                    print("Error generating image: \(error)")
                    dispatchGroup.leave() // Ensure leave is called if an error is caught
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("Finished sending all frames")
            // Perform any action needed after all frames have been sent
        }
    }

}

#Preview {
    VideoUploaderView()
}
