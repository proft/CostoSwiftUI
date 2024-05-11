//
//  TransactionCardView.swift
//  Costo
//
//  Created by Ivan Morgun on 23.03.2024.
//

import SwiftUI

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    
    var transaction: Transaction
    var showCategory: Bool = false
    
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text(String(transaction.title.prefix(1)))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.title)
                        .foregroundStyle(.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    if showCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                    }
                }
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 1))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.background, in: .rect(cornerRadius: 8))
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
            }
        }
    }
}
