//
//  Carousel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct Carousel: View {
    
    let carouselViews: [CarouselEnum] = [.furture, .analytics, .support]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State var selectedIdx: Int = 0
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selectedIdx) {
                ForEach(0..<carouselViews.count, id: \.self) { idx in
                    ZStack(alignment: .topLeading) {
                        CarouselNavigation(selectedCarousel: carouselViews[idx])
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: 20)
                    .cornerRadius(12)
                    .padding(.horizontal, 160)
                
                HStack(spacing: 8) {
                    ForEach(0..<carouselViews.count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedIdx ? Color.white : Color.secondary)
                            .frame(width: 8, height: 8)
                            .onTapGesture {
                                selectedIdx = index
                            }
                    }
                    
                }
            }
            .frame(height: 30)
            .padding(.top, 330)
            .onReceive(timer) { _ in
                withAnimation(.default) {
                    selectedIdx = (selectedIdx + 1) % carouselViews.count
                }
            }
        }
    }
}

#Preview {
    Carousel()
}

enum CarouselEnum: Identifiable {
    case support, analytics, furture
    
    var id: String {
        switch self {
        case .support: return "support"
        case .analytics: return "analytics"
        case .furture: return "features"
        }
    }
}

struct CarouselNavigation: View  {
    
    @State var selectedCarousel: CarouselEnum
    
    var body: some View {
        switch selectedCarousel {
        case .support:
            SupportCarousel()
        case .analytics:
            AnalyticsCarousel()
        case .furture:
            FurtureCarousel()
        }
    }
    
}
