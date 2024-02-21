//
//  Home.swift
//  BANOUN
//
//  Created by Mobilions iOS on 04/01/24.
//
var GscreenSize: CGSize = .zero

import SwiftUI

struct Home: View {
    @Environment(\.presentationMode) var presentationMode
    @State var screenSize: CGSize = .zero
    @State var categoriesData = ["Banner-1", "Banner-1", "Banner-1", "Banner-1", "Banner-1", "Banner-1"]
    @State var categoriesModelData = ["model-1", "model-2", "model-3", "model-4", "model-1", "model-2"]
    @State var newArrivalsImg = ["Product-2", "Product-1", "Product-3", "Product-4", "Product-5", "Product-6"]
    @State var newArrivalsName = ["Spread Collar Shirt with Logo Patch Pocket", "Blue & Pink Vertical Striped Top", "Men Logo Print Slim Fit Shirt with Spread Collar", "Spread Collar Shirt with Logo Patch Pocket", "Blue & Pink Vertical Striped Top", "Men Logo Print Slim Fit Shirt with Spread Collar"]
    @State var newArrivalsTitle = ["THE INDIAN GARAGE CO", "Zink London", "THOMAS SCOTT", "RED TAPE", "JACK $ JONES", "THOMAS SCOTT"]
    @State var trendingData = ["Trending_1", "Trending_2", "Trending_3", "Trending_1", "Trending_2", "Trending_3"]
    @State var enableScrollIndicators = false
    @State var loading = false
    @State var designerData = ["BreakBounce", "Park_Avenue", "BlackBerry", "Arrow", "BreakBounce", "Park_Avenue", "BlackBerry", "Arrow"]
    @State var isWishlist = "golden_wishlist_bordered"
    @State var image = UIImage(named: "user_2")!
    var imageData = ["baby", "baby-2", "baby-3"]
    var topDeals = ["Top_deals_4", "Top_deals_2", "Top_deals_3", "Top_deals_1"]
    @State private var offset = CGFloat.zero
    @State private var currentPage = 0
    
    // MARK: - Nav Actions
    
    @State var actionCategories = false
    @State var actionNewArrivals = false
    @State var actionInspiration = false
    @State var actionDesigners = false
    @State var actionTrending = false
    @State var actionSearch = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                //  MARK: - Get screen size
                GeometryReader(content: { geometry in
                    HStack {}.onAppear(perform: {
                        screenSize = geometry.size
                        GscreenSize = geometry.size
                    })
                })
                
                
                // MARK: - Navigation
                VStack() {
                    HStack(alignment: .center) {
                        Spacer().frame(width: screenSize.width / 4)
                        Image("AZCART")
                            .frame(width: abs(screenSize.width / 2))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("search_icon")
                        }.padding(.trailing, 20)
                    }
                    .frame(height: 48)
                    
                    // MARK: - Scroll view
                    
                    ScrollView {
                        // MARK: - Delivery description
                        
                        HStack() {
                            Spacer()
                            HStack(spacing: 5) {
                                Image("car_icon")
                                    .resizable()
                                    .frame(width: 50, height: 25)
                                Text("Free delivery an above order $200")
                                    .font(.custom(getPoppinsFont(weight: .Regular), size: 13))
                                    .lineLimit(3)
                                    .foregroundColor(.white)
                            }
                            .frame(width: abs(screenSize.width - 40))
                            Spacer()
                        }
                        .padding(.vertical, 10.0)
                        .background(.primaryRed)
                        .frame(width: abs(screenSize.width))
                        
                        Spacer().frame(height: 24)
                        
                        VStack() {
                            
                            // MARK: - Banner Data
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(0..<imageData.count, id: \.self) { index in
                                        GeometryReader { geometry in
                                            Image(imageData[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: screenSize.width / 1.5, height: 320)
                                                .cornerRadius(16)
                                                .scaleEffect(calculateScale(geometry: geometry))
                                                .animation(.easeInOut, value: calculateScale(geometry: geometry)) // Apply animation here
                                        }
                                        .frame(width: screenSize.width / 1.5, height: 320)
                                        .cornerRadius(16)
                                    }
                                }
                                .cornerRadius(16)
                            }
                            .padding(.horizontal, 20)
                            
                            Spacer().frame(height: 48)
                            
                            // MARK: - New arrivals
                            
                            Text("EXPLORE TOP BRANDS".capitalized(with: .autoupdatingCurrent))
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            Spacer().frame(height: 5)
                            Text("See the latest products in one place")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                            
                            Spacer().frame(height: 20)
                            
                            // MARK: - New arrivals Data
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach( 0..<newArrivalsImg.count, id: \.self) { index in
                                        VStack(alignment: .leading, spacing: 5) {
                                            ProductView(imgUrl: newArrivalsImg[index], width: 140, height: 175, cornerRadius: 16, title: newArrivalsTitle[index].capitalized(with: .autoupdatingCurrent), subCategory: newArrivalsName[index], price: "$250", offerPrice: "$150", showofferPrice: true)
                                            Spacer().frame(height: 20)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            // MARK: - Categories types
                            
                            Text("Shop By Category")
                                .frame(width: abs(screenSize.width), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
                            Spacer().frame(height: 5)
                            Text("We’ve got it all from Tiny to Teens")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                            
                            Spacer().frame(height: 14)
                            VStack(spacing: 15) {
                                if categoriesData.count > 3 {
                                    HStack(spacing:15) {
                                        VStack() {
                                            Image("Shoes")
                                                .resizable()
                                                .frame(width: abs(screenSize.width / 2.2), height: 130)
                                                .cornerRadius(5)
                                            Text("Shoes")
                                                .font(.custom(getPoppinsFont(weight: .Medium), size: 14))
                                        }
                                        VStack() {
                                            Image("Promotional-Banner03")
                                                .resizable()
                                                .frame(width: abs(screenSize.width / 2.2), height: 130)
                                                .cornerRadius(5)
                                            Text("Women")
                                                .font(.custom(getPoppinsFont(weight: .Medium), size: 14))
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    HStack(spacing:15) {
                                        VStack() {
                                            Image("Mens")
                                                .resizable()
                                                .frame(width: abs(screenSize.width / 2.2), height: 130)
                                                .cornerRadius(5)
                                            Text("Mens")
                                                .font(.custom(getPoppinsFont(weight: .Medium), size: 14))
                                        }
                                        VStack() {
                                            Image("Baby-1")
                                                .resizable()
                                                .frame(width: abs(screenSize.width / 2.2), height: 130)
                                                .cornerRadius(5)
                                            Text("Kids")
                                                .font(.custom(getPoppinsFont(weight: .Medium), size: 14))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            Spacer().frame(height: 20)
                            
                            Button("Explore More") {
                                
                            }
                            .frame(width: abs(screenSize.width - 40), height: 48)
                            .cornerRadius(10)
                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
                            .foregroundColor(.primaryBlue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(Color.white10, lineWidth: 1)
                            )
                            
                            Spacer().frame(height: 36)
                            
                            // MARK: - Top Deals
                            
                            VStack() {
                                
                                Text("Top Deals")
                                    .frame(width: abs(screenSize.width - 16))
                                    .font(.custom(getPoppinsFont(weight: .SemiBold), size: 20))
                                
                                Spacer().frame(height: 5)
                                Text("Grab the best deals")
                                    .frame(width: abs(screenSize.width - 50), alignment: .center)
                                    .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 0) {
                                        ForEach(0..<topDeals.count, id: \.self) { index in
                                            Image(topDeals[index])
                                                .resizable()
                                                .frame(width: abs(screenSize.width), height: 200)
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                                .content.offset(x: self.offset)
                                .frame(width: abs(screenSize.width - 32), alignment: .leading)
                                .padding(.leading, -32)
                                .animation(.bouncy, value: offset)
                                .onAppear {
                                    self.offset = -CGFloat(self.currentPage) * screenSize.width
                                }
                                .gesture(
                                    DragGesture()
                                        .onEnded { drag in
                                            let dragThreshold = 10.0
                                            if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
                                                self.currentPage = max(self.currentPage - 1, 0)
                                            } else if drag.predictedEndTranslation.width < -dragThreshold || drag.translation.width < -dragThreshold {
                                                // Snap to next page
                                                self.currentPage = min(self.currentPage + 1, self.topDeals.count - 1)
                                            }
                                            withAnimation {
                                                self.offset = -CGFloat(self.currentPage) * screenSize.width
                                            }
                                        }
                                )
                                
                                // Page indicators
                                HStack(spacing: 5) {
                                    ForEach(0..<topDeals.count, id: \.self) { index in
                                        Circle()
                                            .fill(index == currentPage ? Color.init(hex: HexColor.primary_blue) : Color.init(hex: HexColor.gray))
                                            .frame(width: 5, height: 5)
                                    }
                                }
                                .padding(.top, -20) // Add some space between text and indicators
                            }
                            .onChange(of: currentPage) { newIndex in
                                onPageChange(to: newIndex)
                            }
                            .padding(.horizontal, 16)
                            
                            Spacer().frame(height: 36)
                            
                            // MARK: - Promotional Data
                            
                            Text("Bestsellers in Women's Indian Clothing")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            Spacer().frame(height: 5)
                            Text("Best deals on women's clothing")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                            
                            Spacer().frame(height: 16)
                            
                            VStack(spacing: 16) {
                                VStack() {
                                    Image("Promotional-Banner03")
                                        .resizable()
                                        .cornerRadius(5)
                                }
                                .frame(width: abs((screenSize.width) - 32), height: 250)
                                
                                HStack(spacing: 16) {
                                    Image("Promotional-Banner01")
                                        .resizable()
                                        .cornerRadius(5)
                                        .frame(width: abs((screenSize.width / 2) - 22), height: 160)
                                    Image("Promotional-Banner02")
                                        .resizable()
                                        .cornerRadius(5)
                                        .frame(width: abs((screenSize.width / 2) - 22), height: 160)
                                }
                            }
                            .padding(.horizontal, 16)
                            
                            Spacer().frame(height: 56)
                            
                            // MARK: - Designers
                            
                            Text("WORTHY BRANDS TO BAG".capitalized(with: .autoupdatingCurrent))
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            Spacer().frame(height: 5)
                            Text("Top Best Brands and collections")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                            
                            Spacer().frame(height: 20)
                            
                            // MARK: - Designer data
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach( 0..<designerData.count, id: \.self) { index in
                                        VStack() {
                                            Image(designerData[index])
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .cornerRadius(10)
                                            Text(designerData[index])
                                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14))
                                            Spacer().frame(height: 10)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Spacer().frame(height: 30)
                            
                            // MARK: - Trending
                            
                            Text("Top Picks")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .SemiBold), size: 16))
                            Spacer().frame(height: 5)
                            Text("At rock bottom prices !!")
                                .frame(width: abs(screenSize.width - 50), alignment: .center)
                                .font(.custom(getPoppinsFont(weight: .Regular), size: 14)).foregroundColor(.black50)
                            
                            Spacer().frame(height: 20)
                            
                            // MARK: - Trending Data
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach( 0..<newArrivalsImg.count, id: \.self) { index in
                                        VStack(alignment: .leading, spacing: 5) {
                                            ProductView(imgUrl: newArrivalsImg[index], width: 140, height: 175, cornerRadius: 16, title: "Zink London", subCategory: newArrivalsName[index], price: "$250", offerPrice: "$150", showofferPrice: true)
                                            Spacer().frame(height: 20)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Spacer().frame(height: 20)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .onDisappear(perform: {
                screenSize = .zero
            })
        }
    }
    
    func calculateScale(geometry: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1.0
        let midPoint = UIScreen.main.bounds.width / 2
        let viewFrame = geometry.frame(in: .global)
        let distanceFromCenter = abs(viewFrame.midX - midPoint)
        
        // Decrease scale as it moves away from center
        let threshold: CGFloat = 100 // Change this value to adjust the effect's sensitivity
        if distanceFromCenter < threshold {
            scale = 1 + (threshold - distanceFromCenter) / 500 // Adjust these numbers to control the scale effect
        }
        
        return scale
    }
    
    func onPageChange(to index: Int) {
        debugPrint("Moved to page \(index)")
    }
}

#Preview {
    Home()
}
