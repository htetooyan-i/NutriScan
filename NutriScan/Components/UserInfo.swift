//
//  UserInfo.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct UserInfo: View {
    @State var copiedField: String? = nil
    @State var fieldName: String
    @Binding var fieldValue: String
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(verbatim: fieldValue)
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textContentType(nil)
                Button {
                    UIPasteboard.general.string = fieldValue
                    copiedField = fieldName
                    
                    // Hide message after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copiedField = nil
                    }
                } label: {
                    Image(systemName: "document.on.document")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(10)
                    if copiedField == fieldName {
                        Text("Copied!")
                            .transition(.opacity)
                            .padding(.leading, 0)
                            .padding(.trailing, 10)
                            .padding(.vertical, 10)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PriColor").opacity(0.5))
                )
                .foregroundColor(Color("CustomBlue"))
            }
            .padding(.top, 20)
            .animation(.easeInOut, value: copiedField)
            
        }
    }
}

