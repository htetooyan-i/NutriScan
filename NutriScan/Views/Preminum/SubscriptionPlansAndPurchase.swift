//
//  PremiumSubscriptionPlans.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI


enum SubscriptionPlan {
    case annual
    case monthly
}

struct SubscriptionPlansAndPurchase: View {
    
    @State private var selectedPlan: SubscriptionPlan = .annual
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - Annual Plan
            
            SubscriptionPlanBtn(
                selectedPlan: $selectedPlan,
                planType: .annual,
                title: "Annual",
                promotion: "44% OFF",
                description: "Full access for just $50.00/yr ($4/mo)")
            
            // MARK: - Monthly Plan
            
            SubscriptionPlanBtn(
                selectedPlan: $selectedPlan,
                planType: .monthly,
                title: "Monthly",
                description: "Full access for just $5.00/mo")
            
            // MARK: - Purchase Button

            Button {
                
                HelperFunctions.updateUserAccountInfo(accountType: "premium")
                UserDefaults.standard.set("premium", forKey: "accountType")
                dismiss()
            } label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color("CustomBlue"))
                    .foregroundStyle(Color("InversedPrimary"))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
            
            // MARK: - Restore Premium Button
            
            Text("Restore purchases")
                .font(.caption)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(Color.primary)

        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Color("InversedPrimary")
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
        )
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
