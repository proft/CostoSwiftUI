//
//  SettingsView.swift
//  Costo
//
//  Created by Ivan Morgun on 17.12.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("isAppLockedInBackground") private var isAppLockedInBackground: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("Your name", text: $userName)
                }
                
                Section("App Lock") {
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock when app goes background", isOn: $isAppLockedInBackground)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
