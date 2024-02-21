//
//  CreatePassword.swift
//  BANOUN
//
//  Created by Mobilions iOS on 03/01/24.
//

import SwiftUI

struct CreatePassword: View {
    @Environment(\.presentationMode) var presentationMode
    @State var screenSize: CGSize = .zero
    @State var createPassword = ""
    @State var repeatPassword = ""
    @State var activateButton = false
    @State var createPasswordSecure = true
    @State var repeatPasswordSecure = true
    @State var actionSignIn = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top ) {
                
                //  MARK: - Get screen size
                GeometryReader(content: { geometry in
                    HStack {}
                        .onAppear(perform: {
                            screenSize = geometry.size
                        })
                })
                
                //  MARK: - Navigation title
                
                VStack() {
                    HStack() {
                        Text("Password")
                            .foregroundColor(.black)
                            .font(.custom(getOpenSansFont(weight: .Regular), size: 20))
                    }
                    .frame(height: 44)
                    
                    ScrollView() {
                        Spacer()
                            .frame(height: 20)
                        Text("Please create a  strong password")
                            .foregroundColor(.black)
                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            .frame(width: abs(screenSize.width - 32), alignment: .leading)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        //MARK: - Create password
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Create password")
                                .frame(height: 20)
                                .font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                            HStack() {
                                Group{
                                    if createPasswordSecure {
                                        SecureField(createPassword, text: $createPassword)
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 50)
                                            .onChange(of: createPassword) { i in
                                                if i.count > 5 && repeatPassword.count > 5{
                                                    activateButton = true
                                                } else {
                                                    activateButton = false
                                                }
                                            }
                                            .textFieldStyle(.plain)
                                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                                    } else {
                                        TextField(createPassword, text: $createPassword)
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 50)
                                            .onChange(of: createPassword) { i in
                                                if i.count > 5 && repeatPassword.count > 5{
                                                    activateButton = true
                                                } else {
                                                    activateButton = false
                                                }
                                            }
                                            .textFieldStyle(.plain)
                                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                                    }
                                }
                                .textFieldStyle(.roundedBorder)
                                .animation(.easeInOut(duration: 0.2), value: createPasswordSecure)
                                Button {
                                    createPasswordSecure.toggle()
                                } label: {
                                    Image(createPasswordSecure ? "eye_on" : "eye_off")
                                        .frame(width: 24, height: 24)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                }
                            }
                            .overlay (
                                RoundedRectangle(cornerRadius: 8).stroke(.border, lineWidth: 1)
                            )
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .frame(height: 90).autocorrectionDisabled()
                        
                        
                        Spacer()
                            .frame(height: abs(screenSize.height / 35))
                        
                        //MARK: - Repeat password
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Confirm password")
                                .frame(height: 20)
                                .font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                            HStack() {
                                Group{
                                    if repeatPasswordSecure {
                                        SecureField(repeatPassword, text: $repeatPassword)
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 50)
                                            .onChange(of: repeatPassword) { i in
                                                if i.count > 5 && createPassword.count > 5{
                                                    activateButton = true
                                                } else {
                                                    activateButton = false
                                                }
                                            }
                                            .textFieldStyle(.plain)
                                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                                    } else {
                                        TextField(repeatPassword, text: $repeatPassword)
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 50)
                                            .onChange(of: repeatPassword) { i in
                                                if i.count > 5 && createPassword.count > 5{
                                                    activateButton = true
                                                } else {
                                                    activateButton = false
                                                }
                                            }
                                            .textFieldStyle(.plain)
                                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                                    }
                                }
                                .textFieldStyle(.roundedBorder)
                                .animation(.easeInOut(duration: 0.2), value: repeatPasswordSecure)
                                Button {
                                    repeatPasswordSecure.toggle()
                                } label: {
                                    Image(repeatPasswordSecure ? "eye_on" : "eye_off")
                                        .frame(width: 24, height: 24)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                }
                            }
                            .overlay (
                                RoundedRectangle(cornerRadius: 8).stroke(.border, lineWidth: 1)
                            )
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .frame(height: 90)
                        .autocorrectionDisabled()
                        
                        Spacer()
                            .frame(height: abs(screenSize.height / 35))
                        
                        //MARK: - Btn Done
                        Button("Done") {
                            if activateButton {
                                UserDefaults.standard.set(true, forKey: "LoggedIn")
                                appRootManager.currentRoot = .home
                            }
                        }
                        .frame(width: abs(screenSize.width - 40), height: 50)
                        .background(activateButton ? Color.primaryRed : Color.init(hex: HexColor.primary_red, alpha: 0.5))
                        .foregroundColor(.white).clipShape(.rect(cornerRadius: 10))
                        .font(.custom(getPoppinsFont(weight: .SemiBold), size: 18))
                        .onTapGesture {
                            if activateButton {
                                appRootManager.currentRoot = .home
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreatePassword()
}
