//
//  JoinUs.swift
//  BANOUN
//
//  Created by Mobilions iOS on 03/01/24.
//

import SwiftUI

struct JoinUs: View {
    @State var screenSize: CGSize = .zero
    @State var fullName = ""
    @State var emailAddress = ""
    @State var phoneNumber = ""
    @State var countrySelector = false
    @State var sendOtp = false
    @State var activateButton = false
    @State var actionSignIn = false
    @State var isEmailEditing = false
    @State var isFullNameEditing = false
    @State var isMobileNumberEditing = false
    @Environment(\.presentationMode) var presentationMode
    //    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                //  MARK: - Get screen size
                GeometryReader(content: { geometry in
                    HStack {}.onAppear(perform: {
                        screenSize = geometry.size
                    })
                })
                
                NavigationLink("", isActive: $sendOtp) {
                    VerifyMobile(mobileNumber: phoneNumber)
                }
                NavigationLink("", isActive: $actionSignIn) {
                    SignIn()
                }
                
                // MARK: - Naviagtion
                VStack(alignment: .center) {
                    HStack() {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("close_1")
                                .renderingMode(.original)
                                .resizable()
                        }
                        .frame(width: 25, height: 25)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        Spacer()
                        Text("Register")
                            .frame(width: 120, height: 44 , alignment: .center)
                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                            .padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                        Spacer()
                        Text("")
                        
                    }
                    .frame(width: abs(screenSize.width - 20), height: 48)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    // MARK: - Added Scrollview
                    ScrollView {
                        
                        /// Full Name
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Full Name")
                                .frame(height: 20)
                                .font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                            TextField("", text: $fullName, onEditingChanged: { T in
                                if T {
                                    isFullNameEditing = true
                                    isEmailEditing = false
                                    isMobileNumberEditing = false
                                }
                            })
                            .padding(.horizontal, 10.0)
                            .frame(height: 50)
                            .keyboardType(.emailAddress)
                            .overlay (
                                RoundedRectangle(cornerRadius: 8).stroke(isFullNameEditing ? .primaryBlue : .border, lineWidth: 1)
                            )
                            .onChange(of: fullName) { i in
                                if i.count > 5 && phoneNumber.count > 5{
                                    activateButton = true
                                } else {
                                    activateButton = false
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)).frame(height: 90)
                        .autocorrectionDisabled()
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // MARK: -  Email Address
                        VStack(alignment: .leading, spacing: 5) {
                            HStack() {
                                Text("Email Address")
                                    .frame(height: 20)
                                    .font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                            }
                            TextField("", text: $emailAddress, onEditingChanged: { T in
                                if T {
                                    isFullNameEditing = false
                                    isEmailEditing = true
                                    isMobileNumberEditing = false
                                }
                            })
                            .padding(.horizontal, 10.0)
                            .frame(height: 50)
                            .keyboardType(.emailAddress)
                            .overlay (
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isEmailEditing ? .primaryBlue : .border, lineWidth: 1)
                            )
                            .autocorrectionDisabled()
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .frame(height: 90)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // MARK: - Mobile number
                        VStack(alignment: .leading, spacing: 5) {
                            HStack() {
                                Text("Mobile Number")
                                    .frame(height: 20)
                                    .font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                            }
                            VStack() {
                                HStack(spacing: 1) {
                                    Button(action: {
                                        debugPrint("Button tapped!")
                                    }) {
                                        HStack {
                                            Image("USA")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .padding(.leading, 10)
                                            Text("+1")
                                                .font(.custom(getOpenSansFont(weight: .Regular), size: 14))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    .frame(height: 50)
                                    .foregroundColor(.halfPrimary)
                                    .background(Color.white)
                                    
                                    TextField("", text: $phoneNumber, onEditingChanged: { T in
                                        if T {
                                            isFullNameEditing = false
                                            isEmailEditing = false
                                            isMobileNumberEditing = true
                                        }
                                    })
                                    .padding(.horizontal, 10.0)
                                    .frame(height: 50).keyboardType(.numberPad)
                                    .background(Color.white)
                                    .font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                                    .onChange(of: phoneNumber) { i in
                                        if i.count > 5 && fullName.count > 5 {
                                            activateButton = true
                                        } else {
                                            activateButton = false
                                        }
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isMobileNumberEditing ? .primaryBlue : .border, lineWidth: 1)
                                )
                            }
                            .background(Color.border)
                            
                            Text(isMobileNumberEditing ? "We’ll send a verification code to this number" : "Verify your number")
                                .frame(height: 10)
                                .foregroundColor(isMobileNumberEditing ? .primaryBlue : .black50)
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .frame(height: 100)
                        .font(.custom(getOpenSansFont(weight: .Regular), size: 12))
                        .autocorrectionDisabled()
                        
                        Spacer()
                            .frame(height: 25)
                        
                        // MARK: - Send otp button
                        VStack(alignment: .center) {
                            Button("Send OTP") {
                                activateButton ? (sendOtp = true) : (sendOtp = false)
                            }
                            .frame(width: abs(screenSize.width - 30), height: 50)
                            .background(activateButton ? Color.primaryRed : Color.init(hex: HexColor.primary_red, alpha: 0.5))
                            .foregroundColor(.white)
                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
                            .clipShape(.rect(cornerRadius: 10))
                            .onTapGesture {
                                activateButton ? (sendOtp = true) : (sendOtp = false)
                            }
                            
                            Spacer().frame(height: 24)
                            
                            HStack(spacing: 0) {
                                Text("By continuing you agree to our ")
                                    .font(.custom(getOpenSansFont(weight: .Regular), size: 12))
                                    .foregroundColor(.primary)
                                    .minimumScaleFactor(0.5)
                                Text("terms & conditions")
                                    .font(.custom(getOpenSansFont(weight: .Regular), size: 12))
                                    .foregroundColor(.primary)
                                    .overlay( Divider()
                                        .frame(maxWidth: .infinity, maxHeight:1)
                                        .background(Color.primaryBlue), alignment: .bottom)
                            }
                        }
                        
                        Spacer()
                            .frame(height: screenSize.height / 5)
                        
                        /// Sign in button
                        VStack(alignment: .center) {
                            Text("Have an account?")
                                .font(.custom(getOpenSansFont(weight: .Regular), size: 12))
                                .foregroundColor(.primary)
                            Spacer().frame(height: 16)
                            Button("Sign In") {
                                actionSignIn = true
                            }.frame(width: abs(screenSize.width - 30), height: 50).foregroundColor(.primary).font(.custom(getPoppinsFont(weight: .SemiBold), size: 14)).overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(Color.border, lineWidth: 1)
                            )
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinUs()
}
