//
//  UserPersonalInfo.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI
import Combine

struct UserPersonalInfo: View {
    
    @AppStorage("personalInfoAvailable") var personalInfoAvailable: Bool?
    
    @Binding var showSuccessBanner: Bool
    
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
                
                if isEditing == false {
                    PersonalInfoView()
                        .id(UUID())
                        .onAppear {
                            print("Not Editing")
                        }

                } else {
                    PersonalInfoForm(
                        showSuccessBanner: $showSuccessBanner,
                        isEditing: $isEditing
                    )
                }
                
                
            }
            .foregroundStyle(Color(UIColor.systemGray))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
        .onAppear {
            if let personalInfoAvailable = personalInfoAvailable,
               personalInfoAvailable == true
            {
                isEditing = false
            }else {
                isEditing = true
            }
        }

    }
}


