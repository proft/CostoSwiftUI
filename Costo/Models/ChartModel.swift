//
//  ChartModel.swift
//  Costo
//
//  Created by Ivan Morgun on 01.05.2024.
//

import Foundation

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    var totalValue: Double
    var category: Category
}
