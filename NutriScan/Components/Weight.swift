//
//  Weight.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 1/5/25.
//

import SwiftUI

struct Weight: View {
    @Binding var weight: String
    @Binding var serve: Int
    @State var isDisable: Bool
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                HStack{
                    Image(systemName: "dumbbell")
                        .resizable()
                        .frame(width: 25, height: 20)
                    Text("Weight")
                }
                .foregroundColor(.gray)
                
                // MARK: - WEIGHT InputField
                TextField("", text: Binding(
                    get: {
                        weight
                    },
                    
                    set: {
                        if let doubleValue = Double($0) {
                            if doubleValue.truncatingRemainder(dividingBy: 1) == 0 {
                                // It's an integer
                                self.weight = String(Int(doubleValue))
                            } else {
                                // It's a double with decimal
                                self.weight = String(doubleValue)
                            }
                        }else if $0.isEmpty {
                            self.weight = "0"
                        }
                    }
                ))
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .fontWeight(.bold)
                    .keyboardType(.decimalPad)
                    .disabled(isDisable)
                
                Text("grams")
                    .padding(.horizontal, 5)
                    .foregroundColor(.gray)
            }
            HStack {
                HStack{
                    Image(systemName: "number.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Serves")
                }
                .foregroundColor(.gray)
                
                // MARK: - QUANTITY Inputfield
                TextField("", text: Binding(
                    get: {
                        String(serve)
                    },
                    
                    set: { newServe in
                        if let newServeInt = Int(newServe) {
                            serve = newServeInt
                        }
                    }
                ))
                .frame(height: 50)
                .padding(.horizontal)
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .fontWeight(.bold)
                .keyboardType(.decimalPad)
                .disabled(isDisable)
                
                HStack {
                    // MARK: - Quantity Decrease Button
                    Button {
                        decreaseServe()
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 50, height: 50)
                            .foregroundColor(serve <= 1 ? .red : .blue)
                            .background( serve <= 1 ? Color.red.opacity(0.3): Color.blue.opacity(0.3))
                            .cornerRadius(25)
                            .contentShape(Rectangle())
                    }
                    .disabled(serve <= 1 || isDisable)
                    
                    // MARK: - Quantity Increase Button
                    Button {
                        increaseServe()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 50)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(25)
                            .contentShape(Rectangle())
                    }
                    .disabled(isDisable)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
    }
    // MARK: - Quantity Increase and Decrease Functions
    func increaseServe() {
        serve += 1
        
    }
    func decreaseServe() {
        if serve > 1 {
            serve -= 1
        }
    }
}
