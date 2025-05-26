//
//  OverallDetail.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 26/5/25.
//

import SwiftUI

struct OverallDetail: View {
    @ObservedObject var gptModel = GPTModel.shared
    @State var response: String?
    var body: some View {
        NavigationStack{
            if gptModel.isLoading {
                ProgressView()
            }else{
                Text(response ?? "testing")
                
            }
            
        }
        .onAppear {
            gptModel.callGPT(prompt: "What is the Captial Of Myanmar") { response in
                self.response = response
                DispatchQueue.main.async {
                    print("GPT Response: \(response ?? "No response")")
                    // Update your UI here
                }
            }
        }
        
    }
}

#Preview {
    OverallDetail()
}
