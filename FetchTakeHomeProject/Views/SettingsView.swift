//
//  SettingsView.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var theme: Theme
    @ObservedObject var imageLoader = ImageLoader()
    
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
                
                // MARK: Change themes
                Button(action: {
                    if theme.themeId == Theme.sampleData.last?.themeId {
                        withAnimation {
                            theme.convert(to: Theme.sampleData.first!)
                        }
                        UserDefaults.standard.set(theme.themeId, forKey: "selectedThemeId")
                    } else {
                        withAnimation {
                            theme.convert(to: Theme.sampleData.first(where: { $0.themeId == theme.themeId + 1 }) ?? Theme.sampleData.first!)
                        }
                        UserDefaults.standard.set(theme.themeId, forKey: "selectedThemeId")
                    }
                }, label: {
                    HStack(alignment: .center, spacing: 0){
                        Image(systemName: "paintpalette")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(theme.foreground1)
                            .padding(.trailing, 10)
                        Text("Change app theme")
                            .font(Font.custom("AlteDIN1451Mittelschrift", size: 16))
                            .foregroundColor(theme.foreground1)
                            .kerning(0.3)
                            .lineLimit(1)
                            .minimumScaleFactor(0.01)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    .frame(height: 75)
                    .padding(.horizontal)
                })
                
                Divider()
                    .padding(.horizontal, 10)
                
                Spacer()
            }
            .background(theme.background2)
            .navigationBarBackButtonHidden()
            .preferredColorScheme(theme.systemTheme)
    }
}

#Preview {
    SettingsView()
        .environmentObject(Theme.sampleData.first!)
}
