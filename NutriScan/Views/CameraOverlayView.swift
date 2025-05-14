//
//  CameraOverlayView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 6/5/25.
//

import SwiftUI

struct CameraOverlayView: View {
    let size: CGFloat = 350
    let lineLength: CGFloat = 30
    let lineWidth: CGFloat = 5
    let color: Color = Color("PriColor")
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        ZStack { // Camera Overlay For UI Design
            Color.clear
                .frame(width: size, height: size)
            
            // Top-left
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineLength, height: lineWidth)
                Spacer()
            }
            .frame(width: size, height: size, alignment: .topLeading)
            
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineWidth, height: lineLength)
                Spacer()
            }
            .frame(width: size, height: size, alignment: .topLeading)
            
            // Top-right
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineLength, height: lineWidth)
                Spacer()
            }
            .frame(width: size, height: size, alignment: .topTrailing)
            
            HStack(spacing: 0) {
                Spacer()
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineWidth, height: lineLength)
            }
            .frame(width: size, height: size, alignment: .topTrailing)
            
            // Bottom-left
            VStack(spacing: 0) {
                Spacer()
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineLength, height: lineWidth)
            }
            .frame(width: size, height: size, alignment: .bottomLeading)
            
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineWidth, height: lineLength)
                Spacer()
            }
            .frame(width: size, height: size, alignment: .bottomLeading)
            
            // Bottom-right
            VStack(spacing: 0) {
                Spacer()
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineLength, height: lineWidth)
            }
            .frame(width: size, height: size, alignment: .bottomTrailing)
            
            HStack(spacing: 0) {
                Spacer()
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .frame(width: lineWidth, height: lineLength)
            }
            .frame(width: size, height: size, alignment: .bottomTrailing)
        }
    }
    
}

#Preview {
    CameraOverlayView()
}
