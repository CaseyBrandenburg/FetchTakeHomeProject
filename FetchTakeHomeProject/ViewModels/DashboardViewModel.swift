//
//  DashboardViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/21/25.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var loadedRecipes: [Recipe]
    @Published var filteredRecipes: [Recipe]
    @Published var highlightedRecipe: Recipe
    @Published var recipeLoadState: LoadState
    @Published var favoriteRecipeIDs: [UUID] {
        didSet {
            print("Saved favorite recipes to userdefaults")
            saveFavoriteRecipes()
        }
    }
    var selectedRecipe: Recipe?
    @Published var searchText: String
    
    init(loadedRecipes: [Recipe] = [],
         filteredRecipes: [Recipe] = [],
         highlightedRecipe: Recipe = Recipe.sampleData.first!,
         recipeLoadState: LoadState = .idle,
         favoriteRecipeIDs: [UUID] = [],
         selectedRecipe: Recipe? = nil,
         searchText: String = ""){
        self.loadedRecipes = loadedRecipes
        self.filteredRecipes = filteredRecipes
        self.highlightedRecipe = highlightedRecipe
        self.recipeLoadState = recipeLoadState
        self.favoriteRecipeIDs = Array(UserDefaults.standard.array(forKey: "favoriteRecipes") as? [String] ?? []).compactMap({ UUID(uuidString: $0) })
        self.selectedRecipe = nil
        self.searchText = searchText
    }
    
    // MARK: gridItems()
    /// Grid items used to display the main recipe list on the dashboard
    func gridItems() -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    }
    
    // MARK: saveFavoriteRecipes()
    /// Takes the current array of Recipe UUID's and saves them to userdefaults, overwriting whatever data was previously saved
    func saveFavoriteRecipes(){
        UserDefaults.standard.set(favoriteRecipeIDs.map({ $0.uuidString }), forKey: "favoriteRecipes")
    }
    
    // MARK: loadRecipes
    /// Retrieve and decode the recipe data from the given URL and use it to update loadedRecipes property
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
        self.highlightedRecipe = self.loadedRecipes.randomElement() ?? self.loadedRecipes.first ?? Recipe.sampleData.first!
        updateFilteredRecipes()
        recipeLoadState = .success
    }
    
    // MARK: updateFilteredRecipes
    /// Updates the filteredRecipes property based on the searchText provided by the user on the dashboard when searching for recipes
    func updateFilteredRecipes() {
        if searchText.isEmpty {
            filteredRecipes = loadedRecipes
        } else {
            filteredRecipes = loadedRecipes.filter { recipe in
                return recipe.name.lowercased().contains(searchText.lowercased()) ||
                recipe.cuisine.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
