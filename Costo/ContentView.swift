//
//  ContentView.swift
//  Costo
//
//  Created by Ivan Morgun on 17.12.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstLogin") private var isFirstLogin: Bool = true
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("isAppLockedInBackground") private var isAppLockedInBackground: Bool = false

    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activeTab) {
            RecentsView()
                .tag(Tab.recents).tabItem { Tab.recents.tabContent }
            
            SearchView()
                .tag(Tab.filters).tabItem { Tab.filters.tabContent }
            
            ChartsView()
                .tag(Tab.charts).tabItem { Tab.charts.tabContent }
            
            SettingsView()
                .tag(Tab.settings).tabItem { Tab.settings.tabContent }
        }
        .tint(Constants.appTint)
        .sheet(isPresented: $isFirstLogin, content: {
            IntroView().interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
