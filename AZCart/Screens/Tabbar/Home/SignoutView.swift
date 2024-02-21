//
//  SignoutView.swift
//  AZCart
//
//  Created by Mobilions iOS on 25/01/24.
//

import SwiftUI

struct SignoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var screenSize: CGSize = .zero
    
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
                
                // MARK: - Navigation Links
                
                // MARK: - Logout
                ZStack(alignment: .top) {
                    VStack(alignment: .center) {
                        Spacer()
                            .frame(height: abs(screenSize.height - 80))
                        Button("Logout") {
                            appRootManager.currentRoot = .splash
                        }
                        .frame(width: abs(screenSize.width - 30), height: 50)
                        .foregroundColor(.white)
                        .background(Color.primaryRed)
                        .cornerRadius(5.0)
                        .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5).stroke(Color.border, lineWidth: 1)
                        )
                        .onTapGesture {
                            appRootManager.currentRoot = .splash
                        }
                    }
                }
                
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SignoutView()
}
