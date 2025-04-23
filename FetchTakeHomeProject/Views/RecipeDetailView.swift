//
//  RecipeDetailView.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var theme: Theme
    @StateObject var imageLoader = ImageLoader()
    var recipe: Recipe
    @Binding var favoriteRecipeIDs: [UUID]
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0){
                // MARK: Header
                HStack(alignment: .center){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 13)
                            .foregroundStyle(theme.foreground2)
                    })
                    
                    Spacer()
                    
                    Image("HeaderGraphic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .colorMultiply(theme.theme1)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13)
                        .foregroundStyle(Color.clear)
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
                
                // MARK: Image
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .zIndex(1)
                } else {
                    ZStack {
                        Rectangle()
                            .fill(theme.background3)
                            .aspectRatio(contentMode: .fit)
                        Image("TitleGraphic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .contrast(0)
                            .brightness(1)
                            .colorMultiply(theme.foreground3)
                            .padding(.horizontal, 30)
                    }
                    .zIndex(1)
                }
                
                // MARK: Title
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 0){
                        Text(recipe.name)
                            .foregroundStyle(theme.foreground1)
                            .font(Font.system(size: 32))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .minimumScaleFactor(0.01)
                        
                        // MARK: Cuisine
                        Text(recipe.cuisine)
                            .foregroundStyle(theme.theme1)
                            .font(Font.system(size: 24))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.top, 5)
                        
                        // MARK: View Recipe
                        if let sourceURL = recipe.sourceURL {
                            Button(action: {
                                UIApplication.shared.open(sourceURL)
                            }, label: {
                                HStack(alignment: .center, spacing: 8){
                                    Text("View recipe online")
                                        .foregroundStyle(theme.foreground2)
                                        .font(Font.system(size: 20))
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                    Image(systemName: "arrow.up.forward.app")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(theme.foreground2)
                                }
                            })
                            .padding(.top, 8)
                        }
                    }
                    .padding(.trailing)
                    
                    Spacer()
                    
                    // MARK: Favorite
                    Button(action: {
                        if favoriteRecipeIDs.contains(recipe.id){
                            favoriteRecipeIDs.removeAll(where: { $0 == recipe.id })
                        } else {
                            favoriteRecipeIDs.append(recipe.id)
                        }
                    }, label: {
                        ZStack {
                            Image(systemName: self.favoriteRecipeIDs.contains(self.recipe.id) ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundStyle(self.favoriteRecipeIDs.contains(self.recipe.id) ? Color.pink : theme.foreground2)
                                .overlay {
                                    Image(systemName: "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .foregroundStyle(theme.foreground2)
                                        .opacity(self.favoriteRecipeIDs.contains(self.recipe.id) ? 1 : 0)
                                }
                        }
                    })
                    .offset(y: 10)
                }
                .padding(.leading, 10)
                .padding(.trailing)
                .padding(.top)
                .background(theme.background2
                    .shadow(radius: 8)
                    .mask(Rectangle().padding(.top, -20))
                )
                .zIndex(3)
                
                Divider()
                    .padding(.horizontal)
                    .padding(.vertical, 25)
                
                // MARK: Youtube Link
                if let youtubeURL = recipe.youtubeURL {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            UIApplication.shared.open(youtubeURL)
                        }, label: {
                            HStack(alignment: .center, spacing: 12){
                                Image("YTLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                VStack(alignment: .leading, spacing: 1){
                                    Text("This recipe has a tutorial!")
                                        .foregroundStyle(theme.foreground1)
                                        .font(Font.system(size: 20))
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                    HStack(alignment: .center, spacing: 8){
                                        Text("Go to tutorial")
                                            .foregroundStyle(theme.foreground2)
                                            .font(Font.system(size: 18))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                        Image(systemName: "arrow.up.forward.app")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15)
                                            .foregroundStyle(theme.foreground2)
                                    }
                                }
                            }
                        })
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .background(theme.background2)
            .navigationBarBackButtonHidden()
            .preferredColorScheme(theme.systemTheme)
            .task {
                if let iconURL = self.recipe.largeImageURL {
                    await imageLoader.load(from: iconURL)
                }
            }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(id: UUID(),
                                    cuisine: "American",
                                    name: "Cheese stuffed cheese",
                                    largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                                    smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                                    sourceURL: URL(string: "www.com"),
                                    youtubeURL: URL(string: "www.com")),
                     favoriteRecipeIDs: .constant([]))
        .environmentObject(Theme.sampleData.first!)
}
