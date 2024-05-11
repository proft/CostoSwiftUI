//
//  DateFilterView.swift
//  Costo
//
//  Created by Ivan Morgun on 03.04.2024.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()
    
    var body: some View {
        VStack(spacing: 16) {
            DatePicker("Start date", selection: $start, displayedComponents: [.date])
            DatePicker("End date", selection: $end, displayedComponents: [.date])
            
            HStack(spacing: 16) {
                Button("Cancel") {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 6))
                .tint(.red)
                
                Button("Filter") {
                    onSubmit(start, end)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 6))
                .tint(Constants.appTint)
            }
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}
