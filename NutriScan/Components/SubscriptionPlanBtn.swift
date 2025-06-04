//
//  SubscriptionPlanBtn.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct SubscriptionPlanBtn: View {
    
    @Binding var selectedPlan: SubscriptionPlan
    @State var planType: SubscriptionPlan
    @State var title: String
    @State var promotion: String?
    @State var description: String
    var body: some View {
        Button {
                selectedPlan = planType
            } label: {
                VStack(spacing: 15) {
                    HStack(alignment: .center) {
                        Image(systemName: selectedPlan == planType ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(selectedPlan == planType ? Color("CustomBlue") : .gray)

                        Text(title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                        Spacer()
                        if let promotion = promotion {
                            Text(promotion)
                                .font(.caption)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(selectedPlan == planType ? Color("CustomBlue") : .gray)
                                )
                                .foregroundStyle(Color("InversedPrimary"))
                        }
                    }
                    
                    Text(description)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.primary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selectedPlan == planType ? Color("CustomBlue") : Color(UIColor.systemGray), lineWidth: 2)
                )
            }
    }
}
