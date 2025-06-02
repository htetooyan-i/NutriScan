//
//  QuickSummaryView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI
import Charts
import Kingfisher

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
    let color: Color
}

struct QuickSummaryView: View {
    @State private var products: [Product] = [
        .init(title: "Annual", revenue: 0.7, color: .red),
        .init(title: "Monthly", revenue: 0.2, color: .yellow),
        .init(title: "Lifetime", revenue: 0.1, color: .purple)
    ]
    
    @Binding var showSummary: Bool
    @State var showSelectedFoods: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Quick Summary")
                    .font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color(UIColor.systemGray))
                    .onTapGesture {
                        self.showSummary = false
                    }
            }
            .padding()
            
            ScrollView() {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .center,spacing: 10) {
                            Image(systemName: "chart.xyaxis.line")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color("PriColor"))
                                .fontWeight(.bold)
                            Text("Price")
                        }
                        QuickSummaryStats()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .center,spacing: 10) {
                            Image(systemName: "chart.pie.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color("PriColor"))
                                .fontWeight(.bold)
                            Text("Macros")
                        }
                        QuickSummaryStats()
                        QuickSummaryStats()
                        QuickSummaryStats()
                        QuickSummaryStats()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    
                    VStack {
                        (Chart(products) { product in
                            SectorMark(
                                angle: .value(
                                    Text(verbatim: product.title),
                                    product.revenue
                                )
                            )
                            .foregroundStyle(product.color)
                        })
                        .frame(maxWidth: .infinity, minHeight: 200)
                        
                        HStack(alignment: .center, spacing: 6) {
                            ForEach(products) { product in
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(product.color)
                                        .frame(width: 10, height: 10)
                                    Text(product.title)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    
                    VStack {
                        HStack {
                            Text("1 Food Selected")
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .rotationEffect(Angle(degrees: showSelectedFoods ? 90 : 0))
                        }
                        if showSelectedFoods {
                            Divider()
                            
                            VStack {
                                HStack {
                                    // IDEA: Display Nutrition Icon Such as Calorie Protein Fat and Fiber
                                    KFImage(URL(string: "https://storage.googleapis.com/nutriscan-893f4.firebasestorage.app/food_thumbnails/apple_pie.jpg"))
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .resizable()
                                        .cacheOriginalImage()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    Text("ApplePie")
                                        .font(Font.custom("ComicRelief-Bold", size: 15))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                    
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                
                            }
                            
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    .onTapGesture {
                        withAnimation {
                            showSelectedFoods.toggle()
                        }
                    }
                    
                }
            }
            .padding()
        }
        .background(
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
        )
        
    }
}
