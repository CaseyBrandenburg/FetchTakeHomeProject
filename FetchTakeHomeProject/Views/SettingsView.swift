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
