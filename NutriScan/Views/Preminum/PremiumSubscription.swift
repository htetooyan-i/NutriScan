//
//  PremiumSubscription.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct PremiumSubscription: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        HStack(spacing: 10) {
                            Text("Preminum")
                                .font(.system(size: 25, weight: .bold, design: .default))
                                .italic()
                            
                            Image(systemName: "crown.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.yellow)
                        }
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(UIColor.systemGray6))
                                .background(
                                    Circle()
                                        .fill(Color(UIColor.systemGray))
                                )
                            
                        }
                        
                    }
                    // MARK: 
                    Carousel()
                    
                    
                }
                .padding()
                
                // MARK: - Subscription Plans Purchase Button
                
                SubscriptionPlansAndPurchase()
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    PremiumSubscription()
}
