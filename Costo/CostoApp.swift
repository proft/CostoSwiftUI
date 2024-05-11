//
//  CostoApp.swift
//  Costo
//
//  Created by Ivan Morgun on 17.12.2023.
//

import SwiftUI
import WidgetKit

@main
struct CostoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
        .modelContainer(for: [Transaction.self])
    }
}

struct Content1View: View {
    let items = ["Long Long long Item 1", "Item 2", "Item 3", "Item long long long 4", "Item 5"]
    let gridItems = [
        GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 20, alignment: .top)
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(items, id: \.self) { item in
                Button(action: { print(item) }, label: {
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.gray, lineWidth: 1)
                            )
                        Text(item)
                            .foregroundColor(.primary)
                    }
                })
            }
        }
    }
}
