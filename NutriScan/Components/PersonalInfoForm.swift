//
//  PersonalInfoForm.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct PersonalInfoForm: View {
    
    @State private var gender: String = ""
    @State private var height: Double = 0
    @State private var weight: Double = 0
    @State private var age: Int = 0
    
    @State private var heightInput: String = ""
    @State private var weightInput: String = ""
    @State private var ageInput: String = ""
    
    @State private var validateResults: [Bool] = [false, false, false, false]
    @State private var validateResult: Bool = false
    
    @Binding var showSuccessBanner: Bool
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            
            HeightTextField(heightInput: $heightInput)
                .onChange(of: heightInput) { _, newValue in
                    if checkHeightInput(for: newValue) {
                        height = Double(newValue)!
                        validateResults[1] = true
                    } else {
                        validateResults[1] = false
                    }
                }
            
            WeightTextField(weightInput: $weightInput)
                .onChange(of: weightInput) { _, newValue in
                    if checkWeightInput(for: newValue) {
                        weight = Double(newValue)!
                        validateResults[2] = true
                    } else {
                        validateResults[2] = false
                    }
                }
            
            AgeTextField(ageInput: $ageInput)
                .onChange(of: ageInput) { _, newValue in
                    if checkAgeInput(for: newValue) {
                        age = Int(newValue)!
                        validateResults[3] = true
                    } else {
                        validateResults[3] = false
                    }
                }
            
            GenderTextField(gender: $gender)
                .onChange(of: gender) { _, newValue in
                    validateResults[0] = checkGenderInput(for: newValue)
                }
            
            Button {
                print("Saved User Personal Info")
                withAnimation {
                    showSuccessBanner = true
                }
                SoundManager.shared.playClickSound()
                
                let personalInfo = [
                    "gender" : gender,
                    "height" : height,
                    "weight" : weight,
                    "age" : age
                ]

                DatabaseModel.createUserInfo(user: UserManager.shared.userId, collectionName: "userInfo", docName: "personalInfo", data: personalInfo) { isSuccess in
                    print("Personal Data have been stored? \(isSuccess)")
                }
                
                gender = ""
                heightInput = ""
                weightInput = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        showSuccessBanner = false
                    }
                }
            } label: {
                Text("Save")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(validateResult ? Color.customBlue : Color(UIColor.systemGray6))
                    )
                    .foregroundStyle(validateResult ? Color.inversedPrimary : Color(UIColor.systemGray))
            }
            .disabled(!validateResult)
        }
        .onChange(of: validateResults) { _, newValue in
            validateResult = newValue.allSatisfy { $0 }
        }
    }
    
    
    func checkHeightInput(for newValue: String) -> Bool {
        if let value = Double(newValue), value > 0 && value < 300 {
            return true
        }
        return false
    }
    
    func checkWeightInput(for newValue: String) -> Bool {
        if let value = Double(newValue), value > 0 && value < 200 {
            return true
        }
        return false
    }
    
    func checkAgeInput(for newValue: String) -> Bool {
        if let value = Int(newValue), value > 0 && value < 150 {
            return true
        }
        return false
    }
    
    func checkGenderInput(for gender: String) -> Bool {
        let lower = gender.lowercased()
        return lower == "male" || lower == "female"
    }
}
