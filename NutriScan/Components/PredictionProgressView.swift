//
//  PredictionProgressView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI

struct PredictionProgressView: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 30, height: 30)
            
            // Percentage Text
            Text("\(Int(progress * 100)) %")
                .font(.system(size: 8, weight: .bold))
                .foregroundColor(.white)
        }
        .background(Color.black.opacity(0.7))
        .clipShape(Circle())
    }
}
