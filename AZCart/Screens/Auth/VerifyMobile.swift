//
//  VerifyMobile.swift
//  BANOUN
//
//  Created by Mobilions iOS on 04/01/24.
//

import SwiftUI

struct VerifyMobile: View {
    @Environment(\.presentationMode) var presentationMode
    @State var screenSize: CGSize = .zero
    @State var mobileNumber = "+911234567890"
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    @State var navToCreatePassword = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                //  MARK: - Get screen size
                GeometryReader(content: { geometry in
                    HStack {}
                        .onAppear(perform: {
                            screenSize = geometry.size
                        })
                })
                
                NavigationLink("", destination: CreatePassword(), isActive: $navToCreatePassword)
                
                // MARK: - Design
                
                VStack(alignment: .center) {
                    HStack() {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("close_1")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 25, height: 25)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Spacer()
                        
                        Text("OTP Verification")
                            .frame(width: 200, height: 44 , alignment: .center)
                            .font(.custom(getOpenSansFont(weight: .Regular), size: 18))
                            .padding(EdgeInsets(top: 0, leading: -40, bottom: 0, trailing: 0))
                        Spacer()
                        Text("")
                        
                    }
                    .frame(width: abs(screenSize.width - 20), height: 48)
                    
                    Spacer()
                        .frame(height: abs(screenSize.height / 20))
                    
                    Image("verify_mobile")
                    
                    Spacer()
                        .frame(height: abs(screenSize.height / 20))
                    
                    Text("Enter the OPT")
                        .font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer().frame(height: 10)
                    
                    HStack(spacing: 0) {
                        Text(mobileNumber)
                            .font(.custom(getOpenSansFont(weight: .Bold), size: 18))
                            .padding(.trailing, 5)
                            .foregroundColor(.black)
                        Text("Change")
                            .font(.custom(getOpenSansFont(weight: .Regular), size: 16))
                            .padding(.trailing, 5)
                            .foregroundColor(.primaryBlue)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .overlay( Divider()
                                .frame(maxWidth: .infinity, maxHeight:1)
                                .background(Color.primaryBlue), alignment: .bottom)
                    }
                    
                    Spacer()
                        .frame(height: abs(screenSize.height / 20))
                    
                    VStack() {
                        HStack(spacing: 0) {
                            ForEach(0...4, id: \.self) { index in
                                OTPTextBox(index)
                            }
                        }.background(content: {
                            TextField("", text: $otpText.limit(5))
                                .tint(.clear)
                                .keyboardType(.numberPad)
                                .textContentType(.oneTimeCode)
                                .frame(width: 1, height: 1)
                                .focused($isKeyboardShowing)
                                .onChange(of: otpText) { newValue in
                                    if newValue.count == 5 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.navToCreatePassword = true
                                        }
                                    }
                                }
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isKeyboardShowing = true
                                    }
                                }
                        })
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isKeyboardShowing = true
                        }
                        .frame(width: abs(screenSize.width - 40))
                    }
                    
                    Spacer()
                        .frame(height: abs(screenSize.height / 20))
                    
                    Button("Resend OTP") {
                        
                    }
                    .frame(width: abs(screenSize.width - 100))
                    .font(.custom(getOpenSansFont(weight: .Bold), size: 18))
                    .foregroundColor(.primaryBlue)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Otp process
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack{
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
                    .foregroundColor(.white)
                    .font(.custom(getPoppinsFont(weight: .SemiBold), size: 24))
            } else {
                Text(" ")
            }
        }
        .frame(width: abs(screenSize.width / 8), height: abs(screenSize.width / 8))
        .background { // Change the background here
            let isFilled = otpText.count > index
            RoundedRectangle(cornerRadius: 10, style: .continuous) // This is the stroke
                .stroke(isKeyboardShowing && otpText.count == index ? .primaryBlue : .border)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous) // This is the fill with corner radius
                        .fill(isFilled ? Color.primaryBlue : Color.clear))
                .animation(.easeInOut(duration: 0.2), value: isKeyboardShowing && otpText.count == index)
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 16))
    }
}

#Preview {
    VerifyMobile()
}

@available(iOS 13.0, *)
extension Binding where Value == String {
    func limit(_ length: Int)->Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
