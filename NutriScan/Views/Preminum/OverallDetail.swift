//
//  OverallDetail.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 26/5/25.
//

import SwiftUI
import MarkdownUI

struct OverallDetail: View {
    @ObservedObject var gptModel = GPTModel.shared
    
    @State var personalInfo: PersonalInfo?
    @State var foodInfo: [String: [FoodData]] = [:]
    
    @State var prompt: String = ""
    @State var response: String = """
    ** There are alittle bit of error.\n Sorry for convenience **
    """

    var body: some View {
        NavigationStack {
            Group {
                if gptModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(UIColor.systemBackground))
                } else {
                    ZStack {
                        Color(UIColor.systemGroupedBackground)
                            .ignoresSafeArea(.all)
                        ScrollView {
                            Markdown(response)
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Overall Review")
        }
        .onAppear {
            if personalInfo != nil {
                self.prompt = HelperFunctions.generatePromtForOverallDetail(personlInfo: personalInfo, foodInfo: foodInfo)
            } else{
                self.prompt = HelperFunctions.generatePromtForOverallDetail(foodInfo: foodInfo)
            }

            gptModel.callGPT(prompt: self.prompt) { response in
                if let response = response {
                    self.response = response
                    print("Response Setted Successfully")
                }
                else {
                    print("Response Failed")
                }
                
            }
        }
        
    }
}

#Preview {
    OverallDetail()
}
