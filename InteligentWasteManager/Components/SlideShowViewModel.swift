//
//  SlideShowViewModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-24.
//

import SwiftUI

// ViewModel to manage the slideshow
class SlideShowViewModel: ObservableObject {
    // Published property to change the current image index
    @Published var currentIndex = 0
    private var timer: Timer?
    private let imagesCount: Int
    private let interval: TimeInterval

    init(imagesCount: Int, interval: TimeInterval = 3.0) {
        self.imagesCount = imagesCount
        self.interval = interval
        setupTimer()
    }

    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.nextImage()
        }
    }

    private func nextImage() {
        // Increment the index to show the next image. Loop back to 0 if at the end.
        currentIndex = (currentIndex + 1) % imagesCount
    }

    // Call this function to stop the slideshow when the view disappears
    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }
}

struct SlideShowView: View {
    @StateObject private var viewModel: SlideShowViewModel
    private let images: [String] // Assuming the images are identified by their names in your assets

    init(images: [String], interval: TimeInterval = 3.0) {
        self.images = images
        _viewModel = StateObject(wrappedValue: SlideShowViewModel(imagesCount: images.count, interval: interval))
    }

    var body: some View {
        TabView(selection: $viewModel.currentIndex) {
            ForEach(images.indices, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFit()
                    .tag(index) // Ensure the tab view can differentiate each image view
                    .background(
                        Rectangle()
                            .background(.white)
                            .opacity(0.4)
                            .frame(width: UIScreen.main.bounds.width / 1.2)
                            .cornerRadius(50))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide the tab view indicators
        .onDisappear {
            viewModel.stopSlideshow() // Stop the timer when the view is not visible
        }
    }
}


#Preview {
    SlideShowView(images: ["Waste management-bro", "Waste management-cuate", "Waste management-pana", "Waste management-rafiki", "wasteManagementPurple"  ])
}
