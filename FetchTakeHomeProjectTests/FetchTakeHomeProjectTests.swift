//
//  FetchTakeHomeProjectTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Casey Brandenburg on 4/21/25.
//

import Testing
@testable import FetchTakeHomeProject
import Foundation

struct RecipeListResponse: Decodable {
    let recipes: [Recipe]
}

struct RecipeTests {
    @Test
    func testRecipeDecoding() async throws {
        let json = """
            {
              "recipes": [
                {
                  "cuisine": "Malaysian",
                  "name": "Apam Balik",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                  "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                  "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                  "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                }
              ]
            }
            """.data(using: .utf8)!
        
        // First decode into a wrapper
        let decoded = try JSONDecoder().decode(RecipeListResponse.self, from: json)
        
        // Then check the inner array
        #expect(decoded.recipes.count == 1)
        
        let recipe = decoded.recipes[0]
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.id.uuidString.lowercased() == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(recipe.largeImageURL?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(recipe.sourceURL?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(recipe.youtubeURL?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
}

struct RecipeServiceTests {
    @Test
    func testFetchRecipesSuccess() async throws {
        let service = MockRecipeService(shouldReturnError: false)
        let recipes = try await service.fetchRecipes()
        
        #expect(!recipes.isEmpty)
        #expect(recipes.first?.name == "Mock Recipe")
    }
    
    @Test
    func testFetchRecipesFailure() async {
        let service = MockRecipeService(shouldReturnError: true)
        
        do {
            _ = try await service.fetchRecipes()
        } catch {
            #expect(true)
        }
    }
}

// Mock Service
struct MockRecipeService {
    enum MockError: Error { case failedFetching }
    
    var shouldReturnError: Bool
    
    func fetchRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw MockError.failedFetching
        } else {
            return [
                Recipe(id: UUID(), cuisine: "MockCuisine", name: "Mock Recipe", largeImageURL: nil, smallImageURL: nil, sourceURL: nil, youtubeURL: nil)
            ]
        }
    }
}

struct ImageLoaderTests {
    @Test
    func testImageLoadingSuccess() async throws {
        let loader = await ImageLoader()
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
        
        await loader.load(from: url)
        
        await #expect(loader.image != nil)
    }
}
