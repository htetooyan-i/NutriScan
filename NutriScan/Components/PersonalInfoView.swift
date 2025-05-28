//
//  PersonalInfoView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct PersonalInfoView: View {

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    @Binding var personalInfo: PersonalInfo
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            PersonalInfoValue(
                iconName: "ruler",
                infoName: "Height",
                infoValue: String(format: "%.1f", personalInfo.height),
                unit: "cm"
            )

            
            PersonalInfoValue(
                iconName: "scalemass",
                infoName: "Weight",
                infoValue: String(format: "%.1f", personalInfo.weight),
                unit: "kg"
            )

            
            PersonalInfoValue(
                iconName: "person.2.fill",
                infoName: "Age",
                infoValue: String(personalInfo.age),
                unit: "years"
            )

            
            PersonalInfoValue(
                iconName: "figure.stand.dress.line.vertical.figure",
                infoName: "Gender",
                infoValue: String(personalInfo.gender)
            )
        }
    }
}
