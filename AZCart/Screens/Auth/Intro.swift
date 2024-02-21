//
//  Intro.swift
//  BANOUN
//
//  Created by Mobilions iOS on 02/01/24.
//

import SwiftUI

struct Intro: View {
    var selectedLanguage = String()
    @State var screenSize: CGSize = .zero
    @State var btnAction = false
    @Environment(\.presentationMode) var presentationMode
    @State var introTitle: [String] = ["Your one stop shop", "The best products and brands", "Find everything you need"]
    @State var subTitle: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Urna elementum egestas viver.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Urna elementum egestas viver.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Urna elementum egestas viver."]
    @State private var currentPage = 0
    var imageData = ["baby", "baby-2", "baby-3"]
    @State var actionGetStarted = false
    @State var actionSignIn = false
    @State var actionSkip = false
    @State private var offset = CGFloat.zero
    @State var isSkip = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GeometryReader(content: { geometry in
                    HStack {}.onAppear(perform: {
                        screenSize = geometry.size
                    })
                })
                
                // MARK: - NAV Links
                NavigationLink("", destination: JoinUs(), isActive: $actionGetStarted)
                NavigationLink("", destination: SignIn(), isActive: $actionSignIn)
                
                VStack(alignment: .center) {
                    VStack() {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            // MARK: - Btn Skip
                            Button("Skip") {
                                appRootManager.currentRoot = .home
                            }
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
                            .font(.custom(getOpenSansFont(weight: .Bold), size: 15))
                            .foregroundColor(.init(hex: "#89909E"))
                            .onTapGesture {
                                appRootManager.currentRoot = .home
                            }
                        }
                        .frame(width: screenSize.width, height: 48)
                        
                        Spacer()
                            .frame(height: screenSize.height / 30)
                        Text(introTitle[$currentPage.wrappedValue])
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("Primary-Blue")/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center).frame(width: screenSize.width, height: 30)
                            .lineLimit(2)
                            .font(.custom(getOpenSansFont(weight: .Bold), size: 18))
                        
                        Spacer()
                            .frame(height: 8)
                        Text(subTitle[$currentPage.wrappedValue])
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("Half-Primary")/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center).padding(.horizontal, 40.0)
                            .frame(width: screenSize.width)
                            .lineLimit(5)
                            .font(.custom(getOpenSansFont(weight: .Regular), size: 14))
                        
                        
                    }
                    .padding(.top, -20.0)
                    .frame(width: screenSize.width, height: screenSize.height / 5)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    VStack() {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(0..<imageData.count, id: \.self) { index in
                                    Image(imageData[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenSize.width, height: screenSize.height / 2)
                                }
                            }
                        }
                        .content.offset(x: self.offset)
                        .frame(width: screenSize.width, alignment: .leading)
                        .animation(.bouncy, value: offset)
                        .onAppear {
                            self.offset = -CGFloat(self.currentPage) * screenSize.width // Initialize the correct offset when the view appears
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { drag in
                                    // Calculate which way to snap based on drag velocity and position
                                    let dragThreshold = 10.0
                                    if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
                                        // Snap to previous page
                                        self.currentPage = max(self.currentPage - 1, 0)
                                    } else if drag.predictedEndTranslation.width < -dragThreshold || drag.translation.width < -dragThreshold {
                                        // Snap to next page
                                        self.currentPage = min(self.currentPage + 1, self.imageData.count - 1)
                                    }
                                    withAnimation {
                                        self.offset = -CGFloat(self.currentPage) * screenSize.width
                                    }
                                }
                        )
                        
                        // Page indicators
                        HStack(spacing: 5) {
                            ForEach(0..<imageData.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage ? Color.init(hex: HexColor.primary_blue) : Color.init(hex: HexColor.gray))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.top, 10) // Add some space between text and indicators
                    }
                    .onChange(of: currentPage) { newIndex in
                        onPageChange(to: newIndex)
                    }
                    .frame(height: screenSize.height / 1.8)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    
                    Spacer()
                    
                    // MARK: - Btn get started
                    VStack(alignment: .center) {
                        Button("Get started") 
                        { 
                            actionGetStarted = true
                        }
                        .frame(width: abs(screenSize.width - 80), height: 50)
                        .background(Color.primaryRed)
                        .foregroundColor(.white)
                        .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
                        .clipShape(.rect(cornerRadius: 10))
                        .onTapGesture {
                            actionGetStarted = true
                        }
                        
                        Button("Already have an account? Sign in") {
                            actionSignIn = true
                        }
                        .frame(width: abs(screenSize.width - 80), height: 50)
                        .foregroundColor(.init(hex: HexColor.primary_blue))
                        .font(.custom(getOpenSansFont(weight: .Regular), size: 12))
                        .onTapGesture {
                            actionSignIn = true
                        }
                    }
                }.onDisappear(perform: {
                    if isSkip == false {
                        screenSize = .zero
                        currentPage = 0
                    }
                })
            }
        }.navigationBarBackButtonHidden().onDisappear {
            currentPage = 0
        }
    }
    
    func onPageChange(to index: Int) {
        debugPrint("Moved to page \(index)")
    }
}

#Preview {
    Intro()
}
