//
//  AnalyticsCarousel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI
import Charts

struct DemoData: Identifiable, Hashable {
    var id = UUID()
    var date: String
    var value: Int
}

struct AnalyticsCarousel: View {
    let data: [DemoData]
    init() {
        self.data = [
            DemoData(date: "June 1", value: 200),
            DemoData(date: "June 2", value: 100),
            DemoData(date: "June 3", value: 340),
            DemoData(date: "June 4", value: 20),
        ]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "chart.bar.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(UIColor.systemGray))
                Text("Food Stats And Summary")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
            }
            
            VStack(spacing: 10) {
                Text("Get a breakdown of your food intake over time.")
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
                    Chart {
                        ForEach(data) { dt in
                            LineMark(
                                x: .value("Day", dt.date),
                                y: .value("Value", dt.value)
                            )
                            .foregroundStyle(Color("CustomBlue"))
                            PointMark(
                                x: .value("Day", dt.date),
                                y: .value("Value", dt.value)
                            )
                            .foregroundStyle(Color("CustomBlue"))
                        }
                        
                        
                    }
                    .frame(height: 150)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(UIColor.systemGray6))
                )
            }
        }
    }
}

#Preview {
    AnalyticsCarousel()
}
