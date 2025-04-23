//
//  RecipeIconView.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import SwiftUI

struct RecipeHighlightView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var imageLoader = ImageLoader()
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            // MARK: Image
            if let image = imageLoader.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 240)
                        .clipped()
                        .overlay(alignment: .bottomLeading){
                            if let _ = self.recipe.youtubeURL {
                                Image("YTLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 45)
                                    .padding([.leading, .bottom], 10)
                            }
                        }
                }
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
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // MARK: Description
            Text(recipe.name)
                .foregroundStyle(theme.foreground1)
                .font(.title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
                .padding(.leading)
                .padding(.top, 7)
            
            Text(recipe.cuisine)
                .foregroundStyle(theme.theme1)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.leading)
        }
        .task {
            if let iconURL = self.recipe.largeImageURL {
                await imageLoader.load(from: iconURL)
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        RecipeHighlightView(recipe: Recipe(id: UUID(),
                                      cuisine: "Brazilian",
                                      name: "Super Eggs",
                                      largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                                      smallImageURL: nil,
                                      sourceURL: nil,
                                      youtubeURL: URL(string: "www.com")))
            .environmentObject(Theme.sampleData.first!)
        Spacer()
    }
    .background(Color("DarkMode_BG2"))
    .ignoresSafeArea()
}
