//
//  AccountAuthSheetView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct AccountAuthSheetView: View {
    @Binding var toggler: Bool
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color(UIColor.systemGray6)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        VStack {
                            Text("NutriScan")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            NavigationLink {
                                UserSignUp()
                            } label: {
                                LogInAndSignUpBtn(icon: "envelope.fill", description: "Sign up with email", bgColor: Color(UIColor.systemGray6), borderColor: Color.white)
                                
                            }

                            NavigationLink {
                                UserLoginForm()
                            } label: {
                                LogInAndSignUpBtn(description: "Log in", bgColor: Color.white, borderColor: Color(UIColor.systemGray6))
                            }

                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5 + geometry.safeAreaInsets.bottom)
                        .background(
                            Color.white
                                .clipShape(RoundedCorner(radius: 50, corners: [.topLeft, .topRight]))
                        )
                        .ignoresSafeArea(.all, edges: .bottom)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color(UIColor.systemGray3))
                            .onTapGesture {
                                toggler = false
                            }
                    }
                }
            }
        }
    }

    struct RoundedCorner: Shape {
        var radius: CGFloat
        var corners: UIRectCorner

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
}


#Preview {
    let test: Binding<Bool> = .constant(true)
    AccountAuthSheetView(toggler: test)
}
