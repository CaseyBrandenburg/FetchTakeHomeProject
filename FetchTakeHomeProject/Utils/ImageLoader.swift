//
//  ImageLoader.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import Foundation
import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var url: URL?
    
    /// Load an image from a given URL, cache it, and save it to disk
    func load(from url: URL) async {
        self.url = url
        print("Loading image from: \(url.absoluteString)")
        
        // Check memory cache
        if let cached = ImageCache.shared.image(for: url) {
            print("Image pulled from cache")
            self.image = cached
            return
        }
        
        // Check disk
        if let diskImage = ImageCache.shared.loadFromDisk(for: url) {
            print("Image pulled from disk")
            ImageCache.shared.setImage(diskImage, for: url)
            self.image = diskImage
            return
        }
        
        // Download
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let downloadedImage = UIImage(data: data) else {
                print("Failed downloading image")
                return
            }
            print("Image downloaded")
            ImageCache.shared.setImage(downloadedImage, for: url)
            ImageCache.shared.saveToDisk(downloadedImage, for: url)
            self.image = downloadedImage
        } catch {
            print("Failed to load image from \(url): \(error)")
        }
    }
}
