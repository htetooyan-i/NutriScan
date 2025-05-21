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
            GeometryReader { geometry in // use to check device frame
                ZStack(alignment: .top) {
                    Color(UIColor.systemGray6)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        VStack { // logo part
                            Text("NutriScan")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                        
                        VStack(alignment: .center, spacing: 20) { // login and signup option part
                            
                            NavigationLink { // navigation link for sign up form
                                UserSignUpForm(toggler: $toggler)
                            } label: {
                                LogInAndSignUpBtn(icon: "envelope.fill", description: "Sign up with email", bgColor: Color(UIColor.systemGray6), borderColor: Color("InversedPrimary"))
                                
                            }

                            NavigationLink { // navigation link for login in form
                                UserLoginForm(toggler: $toggler)
                            } label: {
                                LogInAndSignUpBtn(description: "Log in", bgColor: Color("InversedPrimary"), borderColor: Color(UIColor.systemGray6))
                            }

                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5 + geometry.safeAreaInsets.bottom)
                        .background(
                            Color("InversedPrimary")
                                .clipShape(RoundedCorner(radius: 50, corners: [.topLeft, .topRight]))
                        )
                        .ignoresSafeArea(.all, edges: .bottom)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                }
                .toolbar { // toggler to dismiss sheet view
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

    struct RoundedCorner: Shape { // use to set radius of specific corners
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

