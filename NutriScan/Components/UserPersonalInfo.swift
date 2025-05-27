//
//  UserPersonalInfo.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct UserPersonalInfo: View {
    
    @Binding var showSuccessBanner: Bool
    @Binding var personalInfo: PersonalInfo?
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
            
            VStack(spacing: 30) {
                HStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Personal Info")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                    if personalInfo != nil {
                        Button {
                            print("Edit Personal Data")
                        } label: {
                            Text("Edit")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.sec)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.customOrange)
                                )
                        }

                    }
                }
                
                if let personalInfo = personalInfo {
                    LazyVGrid(columns: columns, alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "ruler")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Height")
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(Color.primary)
                            
                            Text("\(String(format: "%.1f", personalInfo.height)) cm")
                                .fontWeight(.bold)
                                .foregroundStyle(Color(UIColor.systemGray))
                                
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "scalemass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Weight")
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(Color.primary)
                            
                            Text("\(String(format: "%.1f", personalInfo.weight)) kg")
                                .fontWeight(.bold)
                                .foregroundStyle(Color(UIColor.systemGray))
                                
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Age")
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(Color.primary)
                            
                            Text("\(personalInfo.age) years")
                                .fontWeight(.bold)
                                .foregroundStyle(Color(UIColor.systemGray))
                                
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "figure.stand.dress.line.vertical.figure")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Gender")
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(Color.primary)
                            
                            Text(personalInfo.gender)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(UIColor.systemGray))
                                
                        }
                        
                        

                    }
                }else{
                    PersonalInfoForm(showSuccessBanner: $showSuccessBanner)
                }
                
            }
            .foregroundStyle(Color(UIColor.systemGray))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            
        }
    }

}
