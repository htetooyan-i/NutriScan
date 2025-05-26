//
//  StatsList.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 26/5/25.
//

import SwiftUI

struct StatsList: View {
    @State var statIcon: String
    @State var statColor: Color
    @Binding var data: [String: Double]
    @State var statName: String
    @State var unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                Image(systemName: statIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .foregroundStyle(statColor)
                Text("\(statName) Stats")
                    .font(.custom("ComicRelief-Bold", size: 20))
                
            }
            .padding(.bottom, 20)
            
            VStack {
                ForEach(Array(data), id: \.key) { date, value in
                    NavigationLink {
                        SpecificStatsList(date: date, statName: statName, unit: unit)
                    } label: {
                        HStack {
                            Text(date)
                            Spacer()
                            Text(String(format: "%.2f %@", value, unit))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color(UIColor.systemGray6))
                        )
                    }

                }
                
            }
        }
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        .frame(maxWidth: .infinity)
    }
}
