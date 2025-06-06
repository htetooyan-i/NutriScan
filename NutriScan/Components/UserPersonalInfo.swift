//
//  UserPersonalInfo.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI
import Combine

struct UserPersonalInfo: View {
    
    @Binding var showSuccessBanner: Bool
    @Binding var personalInfo: PersonalInfo?
    
    
    
    @State var isEditing: Bool = false

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
                    
                    if !isEditing {
                        Button {
                            print("Edit Personal Data")
                            withAnimation {
                                isEditing = true
                            }
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
                
                if let binding = $personalInfo.unwrap(), isEditing == false {
                    PersonalInfoView(personalInfo: binding)
                        .id(UUID())

                } else if let personalInfo {
                    PersonalInfoForm(
                        gender: personalInfo.gender,
                        height: personalInfo.height,
                        weight: personalInfo.weight,
                        age: personalInfo.age,
                        showSuccessBanner: $showSuccessBanner,
                        isEditing: $isEditing
                    )
                } else {
                    PersonalInfoForm(
                            gender: "",
                            height: 0,
                            weight: 0,
                            age: 0,
                            showSuccessBanner: $showSuccessBanner,
                            isEditing: $isEditing
                        )
                }
                
                
            }
            .foregroundStyle(Color(UIColor.systemGray))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            
            .onAppear {
                if personalInfo == nil {
                    isEditing = true
                }
            }
            .onChange(of: personalInfo) { oldValue, newValue in
                if newValue == nil {
                    isEditing = true
                }
            }
        }
    }
}

extension Binding {
    func unwrap<T>() -> Binding<T>? where Value == T? {
        guard let _ = self.wrappedValue else { return nil }
        return Binding<T>(
            get: { self.wrappedValue! },
            set: { self.wrappedValue = $0 }
        )
    }
}


