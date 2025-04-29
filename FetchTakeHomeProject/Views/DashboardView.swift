//
//  DashboardView.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/21/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel = DashboardViewModel()
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment: .leading, spacing: 0){
                // MARK: Header
                HStack(alignment: .center){
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .foregroundStyle(Color.clear)
                    
                    Spacer()
                    
                    Image("HeaderGraphic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .colorMultiply(theme.theme1)
                    
                    Spacer()
                    
                    Button(action: {
                        path.append(Page.Settings)
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundStyle(theme.foreground2)
                    })
                }
                .padding(.horizontal, 20)
                .padding(.top, 5)
                .padding(.bottom, 12)
                .background(LinearGradient(colors: [theme.background1, theme.background2, theme.background1], startPoint: .leading, endPoint: .trailing))
                .background(theme.background1
                    .shadow(radius:8)
                    .mask(Rectangle().padding(.bottom, -20))
                )
                .zIndex(3)
                
                switch viewModel.recipeLoadState {
                case .idle:
                    // MARK: - Idle
                    GeometryReader { geo in
                        ScrollView {
                            VStack {
                                Spacer()
                                Image(systemName: "arrow.trianglehead.counterclockwise")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                    .foregroundStyle(theme.foreground1)
                                    .padding(.bottom)
                                
                                Text("Refresh to load recipes")
                                    .foregroundStyle(theme.foreground1)
                                    .font(.headline)
                                    .padding(.bottom, 35)
                                Spacer()
                            }
                            .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .refreshable {
                            do {
                                viewModel.recipeLoadState = .loading
                                try await viewModel.loadRecipes()
                            } catch {
                                print("Failed loading recipes")
                                viewModel.recipeLoadState = .failed
                            }
                        }
                    }
                case .success, .loading:
                    // MARK: - Success & Loading
                    GeometryReader { geo in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10){
                                if viewModel.loadedRecipes.isEmpty {
                                    VStack {
                                        Spacer()
                                        Text("There are no recipes available right now\nCome back later and try again")
                                            .foregroundStyle(theme.foreground1)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .padding(.bottom, 40)
                                        Spacer()
                                    }
                                    .frame(width: geo.size.width, height: geo.size.height)
                                } else {
                                    HStack {
                                        Spacer()
                                        ZStack(alignment: .bottomTrailing){
                                            Image("TitleGraphic")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 80)
                                                .colorMultiply(theme.theme3)
                                            Image("HeaderGraphic")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 40)
                                                .rotationEffect(Angle(degrees: -10))
                                                .colorMultiply(theme.theme1)
                                                .offset(x: 12)
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 20)
                                    
                                    Divider()
                                        .padding(.horizontal)
                                    
                                    Text("Our pick for you...")
                                        .foregroundStyle(theme.foreground1)
                                        .font(Font.system(size: 24))
                                        .fontWeight(.bold)
                                        .padding(.leading, 12)
                                        .padding(.top, 10)
                                    
                                    Button(action: {
                                        viewModel.selectedRecipe = viewModel.highlightedRecipe
                                        path.append(Page.RecipeDetail)
                                    }, label: {
                                        RecipeHighlightView(recipe: viewModel.highlightedRecipe)
                                    })
                                    
                                    Divider()
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                    
                                    Text("Your favorites")
                                        .foregroundStyle(theme.foreground1)
                                        .font(Font.system(size: 24))
                                        .fontWeight(.bold)
                                        .padding(.leading, 12)
                                    
                                    if viewModel.favoriteRecipeIDs.isEmpty {
                                        HStack {
                                            Spacer()
                                            Text("You don't have any favorites yet")
                                                .foregroundStyle(theme.foreground2)
                                                .font(Font.system(size: 16))
                                            Spacer()
                                        }
                                        .padding(.vertical, 40)
                                    } else {
                                        LazyVGrid(columns: viewModel.gridItems(), spacing: 10){
                                            ForEach(viewModel.loadedRecipes.filter({ viewModel.favoriteRecipeIDs.contains($0.id) }), id: \.id){ recipe in
                                                Button(action: {
                                                    viewModel.selectedRecipe = recipe
                                                    path.append(Page.RecipeDetail)
                                                }, label: {
                                                    RecipeIconView(recipe: recipe)
                                                        .frame(maxHeight: 230, alignment: .top)
                                                })
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)

                                    VStack(alignment: .leading, spacing: 0){
                                        Text("All Recipes")
                                            .foregroundStyle(theme.foreground1)
                                            .font(Font.system(size: 24))
                                            .fontWeight(.bold)
                                            .padding(.leading, 12)
                                        
                                        TextField("",
                                                  text: $viewModel.searchText,
                                                  prompt: Text("Search for a recipe or cuisine...").foregroundColor(theme.foreground2))
                                            .padding(.leading, 12)
                                            .font(Font.system(size: 16))
                                            .tint(theme.theme1)
                                            .foregroundColor(theme.foreground1)
                                            .padding(.bottom, 10)
                                            .padding(.top, 7)
                                            .onChange(of: viewModel.searchText){ value in
                                                viewModel.updateFilteredRecipes()
                                            }
                                    }
                                    
                                    LazyVGrid(columns: viewModel.gridItems(), spacing: 10){
                                        ForEach(viewModel.filteredRecipes, id: \.id){ recipe in
                                            Button(action: {
                                                viewModel.selectedRecipe = recipe
                                                path.append(Page.RecipeDetail)
                                            }, label: {
                                                RecipeIconView(recipe: recipe)
                                                    .frame(maxHeight: 230, alignment: .top)
                                            })
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        .refreshable {
                            do {
                                try await viewModel.loadRecipes()
                            } catch {
                                print("Failed loading recipes")
                                viewModel.recipeLoadState = .failed
                            }
                        }
                    }
                case .failed:
                    // MARK: - Failed
                    GeometryReader { geo in
                        ScrollView {
                            VStack {
                                Spacer()
                                Text("Something went wrong :(\nRefresh to try again")
                                    .foregroundStyle(theme.foreground1)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 40)
                                Spacer()
                            }
                            .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .refreshable {
                            do {
                                try await viewModel.loadRecipes()
                            } catch {
                                print("Failed loading recipes")
                                viewModel.recipeLoadState = .failed
                            }
                        }
                    }
                }
            }
            .background(theme.background2)
            .preferredColorScheme(theme.systemTheme)
            .task {
                // Reset the selected recipe upon returning home
                viewModel.selectedRecipe = nil
                
                // If the initial recipe load has not been attempted then go ahead and do it
                if viewModel.recipeLoadState == .idle {
                    do {
                        print("Loading recipes")
                        try await viewModel.loadRecipes()
                    } catch {
                        print("Failed loading recipes")
                        viewModel.recipeLoadState = .failed
                    }
                }
            }
            .navigationDestination(for: Page.self, destination: { destination in
                // MARK: Navigation
                switch destination {
                case .RecipeDetail:
                    RecipeDetailView(recipe: self.viewModel.selectedRecipe ?? Recipe.sampleData.first!,
                                     favoriteRecipeIDs: $viewModel.favoriteRecipeIDs)
                case .Settings:
                    SettingsView()
                }
            })
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(Theme.sampleData.first!)
}
