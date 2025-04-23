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
    @ObservedObject var imageLoader = ImageLoader()
    var recipe: Recipe
    
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
                }
                
                // MARK: Description
                Text(recipe.name)
                    .foregroundStyle(theme.foreground1)
                    .font(Font.system(size: 26))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.01)
                
                Text(recipe.cuisine)
                    .foregroundStyle(theme.theme1)
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
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
                                    cuisine: "Brazilian",
                                    name: "Super Eggs",
                                    largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                                    smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                                    sourceURL: nil,
                                    youtubeURL: URL(string: "www.com")))
        .environmentObject(Theme.sampleData.first!)
}
