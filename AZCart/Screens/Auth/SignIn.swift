//
//  SignIn.swift
//  BANOUN
//
//  Created by Mobilions iOS on 03/01/24.
//

import SwiftUI
import Combine

struct SignIn: View {
    //    @StateObject private var appRootManager = AppRootManager()
    @Environment(\.presentationMode) var presentationMode
    @State var screenSize: CGSize = .zero
    @State var emailOrNumber = ""
    @State var password = ""
    @State var activateButton = false
    @State var passwordSecure = true
    @State var actionApple = false
    @State var actionGoogle = false
    @State var actionFacebook = false
    @State var wrongPassword = false
    @State var isEmailEditing = false
    @State var isPasswordEditing = false
    @State var passwordBorderColor = Color.border
    @FocusState var passwordFieldFocused: Bool
    @FocusState var emailFieldFocused: Bool
    @ObservedObject var height = KeyboardResponder()
    @State var showProcced = false
    @State var actionProcced = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top ) {
                //  MARK: - Get screen size
                GeometryReader(content: { geometry in
                    HStack {}.onAppear(perform: {
                        screenSize = geometry.size
                    })
                })
                
                //  MARK: - Navigation title
                
                VStack(alignment: .center) {
                    HStack() {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("close_1").renderingMode(.original).resizable().scaledToFit()
                        }.frame(width: 24, height: 24).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        Spacer()
                        Text("Sign In").frame(width: 120, height: 44 , alignment: .center).font(.custom(getOpenSansFont(weight: .Regular), size: 18)).padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                        Spacer()
                        Text("")
                        
                    }.frame(width: abs(screenSize.width - 20), height: 48)
                    
                    Spacer().frame(height: abs(screenSize.height / 30))
                    
                    // MARK: -  Main content
                    ScrollView {
                        VStack(alignment: .center, spacing: 5) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Email or Mobile number").frame(height: 20).font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                                TextField("", text: $emailOrNumber, onEditingChanged: { T in
                                    if T {
                                        emailFieldFocused = true
                                        if emailFieldFocused == false {
                                            isEmailEditing = true
                                            isPasswordEditing = false
                                        }
                                        showProcced = true
                                        wrongPassword = false
                                        if isPasswordEditing == false {
                                            passwordBorderColor = .border
                                        }
                                    }
                                }, onCommit: {
                                    isEmailEditing = false
                                })
                                .focused($emailFieldFocused)
                                .padding(.horizontal, 10.0)
                                .frame(height: 50)
                                .keyboardType(.emailAddress)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 8).stroke(isEmailEditing ? .black : .border, lineWidth: 1).disabled(true)
                                ).onChange(of: emailOrNumber) { i in
                                    if i.count > 5 && password.count > 5{
                                        activateButton = true
                                    } else {
                                        activateButton = false
                                    }
                                    
                                }.onReceive(height.$currentHeight) { height in
                                    if height == 0 {
                                        showProcced = false
                                    }
                                }
                                .onDisappear {
                                    emailFieldFocused = false
                                }
                            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)).frame(height: 90).autocorrectionDisabled()
                            
                            /// Password
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Password").frame(height: 20).font(.custom(getOpenSansFont(weight: .Regular), size: 15))
                                HStack() {
                                    Group{
                                        if passwordSecure {
                                            SecureField(password, text: $password, onCommit: {
                                                isPasswordEditing = false
                                                passwordBorderColor = .border
                                            })
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 50)
                                            .onChange(of: password) { i in
                                                if i.count > 5 && emailOrNumber.count > 5{
                                                    activateButton = true
                                                    //                                                    wrongPassword = true
                                                } else {
                                                    wrongPassword = false
                                                    activateButton = false
                                                }
                                            }
                                            .textFieldStyle(.plain)
                                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                                            .focused($passwordFieldFocused)
                                            .onTapGesture {
                                                showProcced = true
                                                passwordFieldFocused = true
                                                if passwordFieldFocused == false {
                                                    isPasswordEditing = true
                                                    isEmailEditing = false
                                                    if isPasswordEditing {
                                                        passwordBorderColor = .black
                                                    } else if wrongPassword {
                                                        passwordBorderColor = .defaultRed
                                                    } else {
                                                        passwordBorderColor = .border
                                                    }
                                                }
                                            }.onReceive(height.$currentHeight) { height in
                                                if height == 0 {
                                                    showProcced = false
                                                }
                                            }.keyboardType(.asciiCapable)
                                                .onDisappear {
                                                    passwordFieldFocused = false
                                                }
                                            
                                            
                                        } else {
                                            TextField(password, text: $password, onEditingChanged: { T in
                                                if T {
                                                    isEmailEditing = false
                                                    isPasswordEditing = true
                                                    if isPasswordEditing {
                                                        passwordBorderColor = .black
                                                    } else if wrongPassword {
                                                        passwordBorderColor = .defaultRed
                                                    } else {
                                                        passwordBorderColor = .border
                                                    }
                                                }
                                            }, onCommit: {
                                                isPasswordEditing = false
                                                passwordBorderColor = .border
                                            }).padding(.horizontal, 10.0).frame(height: 50).onChange(of: password) { i in
                                                if i.count > 5 && emailOrNumber.count > 5{
                                                    activateButton = true
                                                    //                                                    wrongPassword = true
                                                } else {
                                                    wrongPassword = false
                                                    activateButton = false
                                                }
                                            }.keyboardType(.asciiCapable).textFieldStyle(.plain).font(.custom(getOpenSansFont(weight: .Regular), size: 18)).onReceive(height.$currentHeight) { height in
                                                if height == 0 {
                                                    showProcced = false
                                                }
                                            }
                                        }
                                    }.textFieldStyle(.roundedBorder)
                                        .animation(.easeInOut(duration: 0.2), value: passwordSecure)
                                    Button {
                                        passwordSecure.toggle()
                                        passwordBorderColor = .border
                                    } label: {
                                        Image(passwordSecure ? "eye_on" : "eye_off")
                                            .frame(width: 24, height: 24).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                    }
                                }.overlay (
                                    
                                    RoundedRectangle(cornerRadius: 8).stroke( passwordBorderColor, lineWidth: 1)
                                )
                            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)).frame(height: 90).autocorrectionDisabled()
                            HStack() {
                                if wrongPassword {
                                    Text("Password is incorrect").frame(width: screenSize.width / 2, alignment: .leading).foregroundColor(.defaultRed).font(.custom(getOpenSansFont(weight: .Regular), size: 14))
                                } else {
                                    Text("")
                                }
                                Spacer()
                                Button("Forget password?") {
                                    
                                }.frame(alignment: .trailing).font(.custom(getOpenSansFont(weight: .SemiBold), size: 14)).foregroundColor(.primaryBlue)
                            }.frame(width: abs(screenSize.width - 40))
                            
                            Spacer().frame(height: abs(screenSize.height / 35))
                            
                            Text("or").font(.custom(getOpenSansFont(weight: .Regular), size: 14)).foregroundColor(.black)
                            
                            Spacer().frame(height: abs(screenSize.height / 35))
                            
                            // MARK: - Button Apple
                            
                            Button {
                                
                            } label: {
                                HStack() {
                                    Image("apple").padding(.leading, 20).frame(width: 24, height: 24)
                                    Spacer()
                                    Text("Continue with Apple").foregroundColor(.black).font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                                    Spacer()
                                }
                            }.frame(width: abs(screenSize.width - 40), height: 50).overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(Color.border, lineWidth: 1)
                            )
                            Spacer().frame(height: 15)
                            
                            // MARK: - Button Google
                            
                            Button {
                                
                            } label: {
                                HStack() {
                                    Image("google").padding(.leading, 20).frame(width: 24, height: 24)
                                    Spacer()
                                    Text("Continue with Google").foregroundColor(.black).font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                                    Spacer()
                                    
                                }
                            }.frame(width: abs(screenSize.width - 40), height: 50).overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(Color.border, lineWidth: 1)
                            )
                            Spacer().frame(height: 15)
                            
                            // MARK:  - Button Facebook
                            Button {
                                
                            } label: {
                                HStack() {
                                    Image("facebook").padding(.leading, 20).frame(width: 24, height: 24)
                                    Spacer()
                                    Text("Continue with Facebook").foregroundColor(.black).font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                                    Spacer()
                                    
                                }
                            }.frame(width: abs(screenSize.width - 40), height: 50).overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(Color.border, lineWidth: 1)
                            )
                            Spacer().frame(height: 40)
                            
                            Text("Not registered with us?").font(.custom(getOpenSansFont(weight: .Regular), size: 14))
                            Spacer().frame(height: 15)
                            
                            // MARK:  - Button Join Banouny
                            
                            Button("Join Banouny") {
                                
                            }.frame(width: abs(screenSize.width - 40), height: 50).background(Color.primaryRed).foregroundColor(.white).clipShape(.rect(cornerRadius: 10)).font(.custom(getPoppinsFont(weight: .SemiBold), size: 18))
                        }
                    }.overlay(
                        
                        // MARK: - Btn Procceed
                        
                        VStack() {
                            Button("Procced") {
                                if activateButton {
                                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                                    appRootManager.currentRoot = .home
                                }
                            }
                            .frame(width: abs(screenSize.width - 40), height: showProcced ? 50 : 0)
                            .background(activateButton ? Color.init(hex: HexColor.primary_red) : Color.init(hex: HexColor.primary_red, alpha: 0.5))
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundColor(.white)
                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            .onTapGesture(perform: {
                                if activateButton {
                                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                                    appRootManager.currentRoot = .home
                                }
                            })
                        }
                            .frame(width: abs(screenSize.width), height: showProcced ? 80 : 0)
                            .background(.white)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -4)
                        ,
                        alignment: .bottom
                    )
                    
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SignIn()
}

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.publisher(for: UIResponder.keyboardWillShowNotification).compactMap {
            $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        }
        .map { $0.height }
        .assign(to: \.currentHeight, on: self)
        .store(in: &cancellableSet)
        
        notificationCenter.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellableSet)
        debugPrint("Current height :: \(currentHeight)")
        if currentHeight < 50 {
            currentHeight = UIScreen.main.bounds.height
        }
    }
}
