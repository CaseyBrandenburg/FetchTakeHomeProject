//
//  ImageCacheExtensions.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import Foundation
import UIKit

// MARK: ImageCache
extension ImageCache {
    private var diskCacheURL: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    /// Convert full URL string to a safe filename using percent encoding
    private func filenameFromURL(_ url: URL) -> String {
        return url.path.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }

    /// Load an image into memory from the disk as a UIImage, given the image's URL
    func loadFromDisk(for url: URL) -> UIImage? {
        let fileURL = diskCacheURL.appendingPathComponent(filenameFromURL(url))
        guard let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    /// Save an image to disk
    func saveToDisk(_ image: UIImage, for url: URL) {
        let fileURL = diskCacheURL.appendingPathComponent(filenameFromURL(url))
        guard let data = image.pngData() else { return }
        try? data.write(to: fileURL)
    }
}
