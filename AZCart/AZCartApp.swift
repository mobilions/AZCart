//
//  Banoun_DemoApp.swift
//  Banoun_Demo
//
//  Created by Mobilions iOS on 17/01/24.
//

import SwiftUI

var appRootManager = AppRootManager()

@main
struct AZCartApp: App {
    @StateObject var appRootManager1 = appRootManager
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager1.currentRoot {
                case .splash:
                    Splash()
                case .home:
                    TabbarView(selectedTab: 0)
                }
            }
            .environmentObject(appRootManager1)
        }
    }
}
