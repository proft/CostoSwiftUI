//
//  CardView.swift
//  Costo
//
//  Created by Ivan Morgun on 18.12.2023.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                        .foregroundStyle(Color.primary)
                    
                    Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundColor(expense > income ? .red : .green)
                }
                .padding(.bottom, 26)
                
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let isIncome = category == .income
                        let img = isIncome ? "arrow.down" : "arrow.up"
                        let tint = isIncome ? Color.green : Color.red
                        
                        HStack(spacing: 10) {
                            Image(systemName: img)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text(currencyString(isIncome ? income : expense, allowedDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.primary)
                            }
                            
                            if isIncome {
                                Spacer(minLength: 10)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], 26)
            .padding(.top, 16)
        }
    }
}

#Preview {
    CardView(income: 45000, expense: 12000)
}
