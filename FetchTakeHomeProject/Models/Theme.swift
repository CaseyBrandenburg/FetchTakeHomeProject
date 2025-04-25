//
//  Theme.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import Foundation
import SwiftUI

class Theme: ObservableObject, Identifiable, Copyable {
    var id: UUID = UUID()
    @Published var themeId: Int
    @Published var systemTheme: ColorScheme
    @Published var background1: Color
    @Published var background2: Color
    @Published var background3: Color
    @Published var foreground1: Color
    @Published var foreground2: Color
    @Published var foreground3: Color
    @Published var theme1: Color
    @Published var theme2: Color
    @Published var theme3: Color
    
    init(background1: Color = Color("DarkMode_BG1"),
         background2: Color = Color("DarkMode_BG2"),
         background3: Color = Color("DarkMode_BG3"),
         foreground1: Color = Color("DarkMode_FG1"),
         foreground2: Color = Color("DarkMode_FG2"),
         foreground3: Color = Color("DarkMode_FG3"),
         theme1: Color = Color("DarkMode_T1"),
         theme2: Color = Color("DarkMode_T2"),
         theme3: Color = Color("DarkMode_T3"),
         themeId: Int = 0,
         systemTheme: ColorScheme = .dark){
        self.background1 = background1
        self.background2 = background2
        self.background3 = background3
        self.foreground1 = foreground1
        self.foreground2 = foreground2
        self.foreground3 = foreground3
        self.theme1 = theme1
        self.theme2 = theme2
        self.theme3 = theme3
        self.themeId = themeId
        self.systemTheme = systemTheme
    }
    
    /// Converts the current instance to a new theme being passed in
    func convert(to newTheme: Theme){
        self.background1 = newTheme.background1
        self.background2 = newTheme.background2
        self.background3 = newTheme.background3
        self.foreground1 = newTheme.foreground1
        self.foreground2 = newTheme.foreground2
        self.foreground3 = newTheme.foreground3
        self.theme1 = newTheme.theme1
        self.theme2 = newTheme.theme2
        self.theme3 = newTheme.theme3
        self.themeId = newTheme.themeId
        self.systemTheme = newTheme.systemTheme
    }
}

extension Theme {
    static let sampleData: [Theme] = [
        Theme(background1: Color("LightMode_BG1"),
              background2: Color("LightMode_BG2"),
              background3: Color("LightMode_BG3"),
              foreground1: Color("LightMode_FG1"),
              foreground2: Color("LightMode_FG2"),
              foreground3: Color("LightMode_FG3"),
              theme1: Color("LightMode_T1"),
              theme2: Color("LightMode_T2"),
              theme3: Color("LightMode_T3"),
              themeId: 0,
              systemTheme: .light),
        Theme(background1: Color("DarkMode_BG1"),
              background2: Color("DarkMode_BG2"),
              background3: Color("DarkMode_BG3"),
              foreground1: Color("DarkMode_FG1"),
              foreground2: Color("DarkMode_FG2"),
              foreground3: Color("DarkMode_FG3"),
              theme1: Color("DarkMode_T1"),
              theme2: Color("DarkMode_T2"),
              theme3: Color("DarkMode_T3"),
              themeId: 1,
              systemTheme: .dark),
        Theme(background1: Color("ForestMode_BG1"),
              background2: Color("ForestMode_BG2"),
              background3: Color("ForestMode_BG3"),
              foreground1: Color("ForestMode_FG1"),
              foreground2: Color("ForestMode_FG2"),
              foreground3: Color("ForestMode_FG3"),
              theme1: Color("ForestMode_T1"),
              theme2: Color("ForestMode_T2"),
              theme3: Color("ForestMode_T3"),
              themeId: 2,
              systemTheme: .dark)
    ]
}
