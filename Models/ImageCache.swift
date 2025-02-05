//
//  ImageCache.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 2/3/25.
//


import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let cacheDirectory: URL
    
    private init() {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("ImageCache")
        
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        let filePath = cacheDirectory.appendingPathComponent(safeFilename(for: url))
        if let data = try? Data(contentsOf: filePath) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func saveImageToCache(_ image: UIImage, for url: URL) {
        let filePath = cacheDirectory.appendingPathComponent(safeFilename(for: url))
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: filePath)
        }
    }

    private func safeFilename(for url: URL) -> String {
        return url.absoluteString
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")
            .replacingOccurrences(of: "?", with: "_")
    }
}
