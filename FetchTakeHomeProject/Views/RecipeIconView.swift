//
//  RecipeIconView.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import SwiftUI

struct RecipeIconView: View {
    @EnvironmentObject var theme: Theme
    @ObservedObject var imageLoader = ImageLoader()
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: Image
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(alignment: .bottomLeading){
                        if let _ = self.recipe.youtubeURL {
                            Image("YTLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 25)
                                .padding([.leading, .bottom], 7)
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
                .font(Font.system(size: 18))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
            
            Text(recipe.cuisine)
                .foregroundStyle(theme.theme1)
                .font(Font.system(size: 16))
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .fixedSize(horizontal: false, vertical: true)
        .task {
            if let iconURL = self.recipe.smallImageURL {
                await imageLoader.load(from: iconURL)
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        RecipeIconView(recipe: Recipe(id: UUID(),
                                      cuisine: "Brazilian",
                                      name: "Super Eggs",
                                      largeImageURL: nil,
                                      smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                                      sourceURL: nil,
                                      youtubeURL: URL(string: "www.com")))
            .environmentObject(Theme.sampleData.first!)
        Spacer()
    }
    .background(Color("DarkMode_BG2"))
    .ignoresSafeArea()
}
