//
//  FetchTakeHomeProjectApp.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/21/25.
//

import SwiftUI

@main
struct FetchTakeHomeProjectApp: App {
    @StateObject var activeTheme: Theme = Theme()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(activeTheme)
                .task {
                    let themeId = UserDefaults.standard.integer(forKey: "selectedThemeId")
                    self.activeTheme.convert(to: Theme.sampleData.first(where: { $0.themeId == themeId}) ?? Theme.sampleData.first!)
                }
        }
    }
}
