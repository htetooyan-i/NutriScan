//
//  Support.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct SupportCarousel: View {
    
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(UIColor.systemGray))
                Text("Support Food Education")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
            }
            
            VStack(spacing: 10) {
                Text("Your subscription helps us expand NutriScan's food education programs")
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(UIColor.systemGray6))
                    )
                
                VStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.pink)
                        .scaleEffect(animate ? 1.1 : 0.8)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: animate
                        )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(UIColor.systemGray6))
                )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    SupportCarousel()
}
