//
//  PersonalInfoForm.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct PersonalInfoForm: View {
    
    @State var gender: String
    @State var height: Double
    @State var weight: Double
    @State var age: Int
    
    @State private var heightInput: String = ""
    @State private var weightInput: String = ""
    @State private var ageInput: String = ""

    @State private var validateResult: Bool = false
    
    @Binding var showSuccessBanner: Bool
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            
            HeightTextField(heightInput: $heightInput)
                .onChange(of: heightInput) { _, _ in validateAllFields() }
            
            WeightTextField(weightInput: $weightInput)
                .onChange(of: weightInput) { _, _ in validateAllFields() }
            
            AgeTextField(ageInput: $ageInput)
                .onChange(of: ageInput) { _, _ in validateAllFields() }
            
            GenderTextField(gender: $gender)
                .onChange(of: gender) { _, _ in validateAllFields() }
            
            Button {
                print("Saved User Personal Info")
                withAnimation {
                    showSuccessBanner = true
                    if isEditing {
                        UserCache.shared.setPersonalInfo()
                        isEditing = false
                    }
                }
                HelperFunctions.makeVibration(feedbackStyle: .heavy)
                SoundManager.shared.playClickSound()
                
                let personalInfo = [
                    "gender" : gender,
                    "height" : height,
                    "weight" : weight,
                    "age" : age
                ]

                DatabaseModel.createUserInfo(user: UserManager.shared.userId, collectionName: "userInfo", docName: "personalInfo", data: personalInfo) { isSuccess in
                    print("Personal Data have been stored? \(isSuccess)")
                    UserCache.shared.setPersonalInfo()
                }
                
                gender = ""
                heightInput = ""
                weightInput = ""
                ageInput = ""
                
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
        
        .onAppear {
            if height > 0 && weight > 0 && age > 0 && gender != "" {
                self.heightInput = String(format: "%.1f", height)
                self.weightInput = String(format: "%.1f", weight)
                self.ageInput = String(age)
                
                validateAllFields()
            }
        }
    }
    
    func validateAllFields() {
        validateResult = checkInput(
            weight: weightInput,
            height: heightInput,
            age: ageInput,
            gender: gender
        )

        if validateResult {
            height = Double(heightInput) ?? 0
            weight = Double(weightInput) ?? 0
            age = Int(ageInput) ?? 0
        }
    }
    
    
    func checkInput(weight: String, height: String, age: String, gender: String) -> Bool {
        guard let weightValue = Double(weight), weightValue > 0 && weightValue < 300 else {
            return false
        }
        
        guard let heightValue = Double(height), heightValue > 0 && heightValue < 300 else {
            return false
        }
        
        guard let ageValue = Int(age), ageValue > 0 && ageValue < 120 else {
            return false
        }
        
        let validGenders = ["male", "female", "other"]
        guard validGenders.contains(gender.lowercased()) else {
            return false
        }
        
        return true
    }
    
    
}
