//
//  CachedAsyncImage.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 2/3/25.
//

// Cache image logic


import SwiftUI

struct CachedAsyncImage: View {
    let url: String?
    @State private var uiImage: UIImage?
    @State private var currentURL: String?

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
            } else {
                ProgressView()
                    .frame(width: 70, height: 70)
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .onChange(of: url) { newValue in
            if newValue != currentURL {
                uiImage = nil
                currentURL = nil
                loadImage()
            }
        }
    }
    
    private func loadImage() {
        guard let urlString = url, let url = URL(string: urlString) else { return }

        // No duplicate loads
        if currentURL == urlString { return }
        currentURL = urlString
        
        // Check cache first
        Task {
            if let cachedImage = ImageCache.shared.getCachedImage(for: url) {
                DispatchQueue.main.async {
                    self.uiImage = cachedImage
                }
                return
            }

            // Fetch image from the network
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Ensure the image is still assigned to the correct URL
                        if self.currentURL == urlString {
                            self.uiImage = image
                            ImageCache.shared.saveImageToCache(image, for: url)
                        }
                    }
                }
            } catch {
                print("Image loading failed: \(error)")
            }
        }
    }
}
