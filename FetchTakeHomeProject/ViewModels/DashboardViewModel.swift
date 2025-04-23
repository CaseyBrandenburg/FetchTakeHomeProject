//
//  DashboardViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/21/25.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var loadedRecipes: [Recipe]
    @Published var recipeLoadState: LoadState
    var selectedRecipe: Recipe?
    
    init(loadedRecipes: [Recipe] = [],
         recipeLoadState: LoadState = .idle,
         selectedRecipe: Recipe? = nil){
        self.loadedRecipes = loadedRecipes
        self.recipeLoadState = recipeLoadState
        self.selectedRecipe = nil
    }
    
    func gridItems() -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    }
    
    @MainActor
    func loadRecipes() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        struct RecipeWrapper: Decodable {
            let recipes: [Recipe]
        }
        
        let decoder = JSONDecoder()
        let wrapper = try decoder.decode(RecipeWrapper.self, from: data)
        self.loadedRecipes = wrapper.recipes
        recipeLoadState = .success
    }
}
