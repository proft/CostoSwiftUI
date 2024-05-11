//
//  NewExpenseView.swift
//  Costo
//
//  Created by Ivan Morgun on 05.04.2024.
//

import SwiftUI
import WidgetKit

struct NewExpenseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var created: Date = .now
    @State private var category: Category = .expense
    @State var tint: TintColor = TintColor.tints.randomElement()!
    
    var numberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 2
        return f
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    dateAdded: created,
                    category: category,
                    tintColor: tint))
                
                CustomSection("Title", "Magic keyboard", value: $title)

                CustomSection("Remarks", "Apple product", value: $remarks)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        .keyboardType(.decimalPad)
                        
                        CategoryCheckBox()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $created, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                }
            }
            .padding(16)
        }
        .navigationTitle(editTransaction == nil ? "Add expense" : "Edit expense")
        .background(.gray.opacity(0.15))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        }
        .onAppear {
            if let editTransaction {
                title = editTransaction.title
                remarks = editTransaction.remarks
                created = editTransaction.dateAdded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                amount = editTransaction.amount
                
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
            }
        }
    }
    
    func save() {
        if editTransaction != nil {
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateAdded = created
        } else {
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: created, category: category, tintColor: tint)
            context.insert(transaction)
        }

        dismiss()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        }
    }
    
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 6) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundColor(Constants.appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(Constants.appTint)
                        }
                    }
                    
                    Text(category.rawValue)
                        .font(.caption)
                }
                .containerShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 8))
    }
}

#Preview {
    NewExpenseView()
}
