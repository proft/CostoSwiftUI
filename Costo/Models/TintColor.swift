//
//  TintColor.swift
//  Costo
//
//  Created by Ivan Morgun on 01.05.2024.
//

import SwiftUI

struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String
    var value: Color
    
    static var tints: [TintColor] = [
        .init(color: "Red", value: .red),
        .init(color: "Blue", value: .blue),
        .init(color: "Pink", value: .pink),
        .init(color: "Purple", value: .purple),
        .init(color: "Brown", value: .brown),
        .init(color: "Orange", value: .orange),
    ]
}
