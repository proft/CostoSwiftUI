//
//  Transaction.swift
//  Costo
//
//  Created by Ivan Morgun on 05.04.2024.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    @Transient
    var color: Color {
        return TintColor.tints.first(where: { $0.color == tintColor})?.value ?? Constants.appTint
    }
    
    @Transient
    var tint: TintColor? {
        return TintColor.tints.first(where: { $0.color == tintColor })
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
}

//var sampleTransactions: [Transaction] = [
//    .init(title: "iPhone", remarks: "Device", amount: 999, dateAdded: .now, category: .expense, tintColor: TintColor.tints.randomElement()!),
//    .init(title: "Apartment", remarks: "Leasing", amount: 2000, dateAdded: .now, category: .income, tintColor: TintColor.tints.randomElement()!),
//    .init(title: "iCloud", remarks: "Subscription", amount: 0.99, dateAdded: .now, category: .expense, tintColor: TintColor.tints.randomElement()!),
//]
