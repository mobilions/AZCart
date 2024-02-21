//
//  Tabview.swift
//  BANOUN
//
//  Created by Mobilions iOS on 04/01/24.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedTab = 0 // This will hold the index of the selected tab
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                Home()
                    .tabItem { Label(
                        title: { Text("Home") },
                        icon: { Image("home")
                            .renderingMode(.template) })
                    }
                    .tag(0)
                
                SignoutView()
                    .tabItem { Label(
                        title: { Text("Categories") },
                        icon: { Image("categories")
                            .renderingMode(.template)  }
                    ) }
                    .tag(1)
                SignoutView()
                    .tabItem { Label(
                        title: { Text("Shopping Bag") },
                        icon: { Image("shopping_bag")
                            .renderingMode(.template)  }
                    ) }
                    .tag(2)
                SignoutView()
                    .tabItem { Label(
                        title: { Text("Wishlist") },
                        icon: { Image("wishlist")
                            .renderingMode(.template)  }
                    ) }
                    .tag(3)
                SignoutView()
                    .tabItem { Label(
                        title: { Text("User") },
                        icon: { Image("user")
                            .renderingMode(.template)  }
                    ) }
                    .tag(4)
                
            }
            .tint(.primaryBlue)
            .navigationBarBackButtonHidden()
            .onAppear(perform: {
                UITabBar.appearance().barTintColor = .white
                UITabBar.appearance().backgroundColor = .white
                let image = UIImage.gradientImageWithBounds(
                    bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 1),
                    colors: [
                        UIColor.clear.cgColor,
                        UIColor.black.withAlphaComponent(0.1).cgColor
                    ]
                )
                
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.black
                
                appearance.backgroundImage = UIImage()
                appearance.shadowImage = image
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabbarView()
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


//struct TabbarView: View {
//    @State private var tabBar = UITabBar()
//    @State var screenSize: CGSize = .zero
//    var body: some View {
//        NavigationView {
//            TabView {
//                Home().tabItem { Label(
//                    title: { Text("Home") },
//                    icon: { Image("home").renderingMode(.template) })
//                }
//                .onAppear { self.tabBar.isHidden = false }
//                .onDisappear { self.tabBar.isHidden = true }
//
//                Categories().tabItem { Label(
//                    title: { Text("Categories") },
//                    icon: { Image("categories").renderingMode(.template)  }
//                ) }
//                ShoppingBag().tabItem { Label(
//                    title: { Text("Shopping Bag") },
//                    icon: { Image("shopping_bag").renderingMode(.template)  }
//                ) }
//                Wishlist().tabItem { Label(
//                    title: { Text("Wishlist") },
//                    icon: { Image("wishlist").renderingMode(.template)  }
//                ) }
//                User().tabItem { Label(
//                    title: { Text("User") },
//                    icon: { Image("user").renderingMode(.template)  }
//                ) }
//
//            }.tint(.primaryBlue).navigationBarBackButtonHidden().onAppear(perform: {
//                UITabBar.appearance().barTintColor = .white
//                UITabBar.appearance().backgroundColor = .white
//                let image = UIImage.gradientImageWithBounds(
//                    bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 1),
//                    colors: [
//                        UIColor.clear.cgColor,
//                        UIColor.black.withAlphaComponent(0.1).cgColor
//                    ]
//                )
//
//                let appearance = UITabBarAppearance()
//                //                appearance.configureWithTransparentBackground()
//                appearance.backgroundColor = UIColor.black
//
//                appearance.backgroundImage = UIImage()
//                appearance.shadowImage = image
//            })
//        }.navigationBarBackButtonHidden()
//    }
//}
