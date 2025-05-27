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
    @State var response: String = """
    **Capital of Myanmar: Naypyidaw**

    Here are some key details about Naypyidaw:

    - 🏛 Became capital in 2005
    - 🇲🇲 Replaced Yangon
    - 🌍 Located in central Myanmar
    - 🏗 Known for wide boulevards and green spaces
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
    }
}

#Preview {
    OverallDetail()
}
