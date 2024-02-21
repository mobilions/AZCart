//
//  Splash.swift
//  AZCart
//
//  Created by Mobilions iOS on 25/01/24.
//

import SwiftUI

var currentScreenSize: CGSize = .zero

struct Splash: View {
    @State var size: CGSize = .zero
    @State var isActive = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                NavigationLink("", destination: Intro(), isActive: $isActive)
                
                GeometryReader { proxy in
                    HStack {}
                        .onAppear {
                            size = proxy.size
                            currentScreenSize = proxy.size
                        }
                }
                
                Color.primaryRed.ignoresSafeArea()
                
                VStack(alignment: .center) {
                    VStack(alignment: .center) {
                        Image("logo")
                            .frame(width: 230, height: 170)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isActive = true
                debugPrint("Is Active :: \(isActive)")
            }
        }
        .onChange(of: isActive) { newValue in
            if !newValue { // When the fullScreenCover is dismissed
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isActive = true
                    debugPrint("Is Active :: \(isActive)")
                }
            }
        }
        .onDisappear(perform: {
            size = .zero
        })
    }
}

#Preview {
    Splash()
}
