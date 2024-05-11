//
//  IntroView.swift
//  Costo
//
//  Created by Ivan Morgun on 17.12.2023.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isFirstLogin") private var isFirstLogin: Bool = true
        
    var body: some View {
        VStack(spacing: 15) {
            Text("What's New\nin the Costo")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 45)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading, spacing: 25) {
                PointView(icon: "dollarsign", title: "Transactions", subTitle: "Keep track of your earnings and expenses")
                
                PointView(icon: "chart.bar.fill", title: "Visual charts", subTitle: "View your transactions using eye-catching charts")
                
                PointView(icon: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expenses you want by advance search and filtering")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            Spacer(minLength: 10)
            
            Button(action: {
                isFirstLogin = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Constants.appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
        .padding(15)
    }
    
    @ViewBuilder
    func PointView(icon: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(Constants.appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    IntroView()
}
