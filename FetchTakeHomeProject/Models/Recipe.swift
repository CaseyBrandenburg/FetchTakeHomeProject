//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/21/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let cuisine: String
    let name: String
    let largeImageURL: URL?
    let smallImageURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case largeImageURL = "photo_url_large"
        case smallImageURL = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

extension Recipe {
    static var sampleData: [Recipe] = [
        Recipe(id: UUID(),
               cuisine: "American",
               name: "Cheese stuffed Cheese",
               largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
               smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
               sourceURL: nil,
               youtubeURL: URL(string: "www.com"))
    ]
}
