////
////  WishlistProductView.swift
////  BANOUN
////
////  Created by Mobilions iOS on 11/01/24.
////
//
//import SwiftUI
//
//func addProduct() -> ProductInfo {
//    var productList = [ProductInfo]()
//    productList.append(ProductInfo(data: ["":""]))
//    return productList[0]
//}
//
//struct WishlistProductView: View {
//    var productData: ProductInfo
//    @State var screenSize: CGSize = .zero
//    @State var currentSize = "Choose Size"
//    let themes = ["Dark", "Light", "Automatic"]
//    
//    var body: some View {
//        ZStack(alignment: .center) {
//            
//            //  MARK: - Get screen size
//            GeometryReader(content: { geometry in
//                HStack {}.onAppear(perform: {
//                    screenSize = geometry.size
//                })
//            })
//            
//            VStack(alignment: .leading) {
//                HStack(spacing: 16) {
//                    AsyncImage(
//                        url: URL(string: productData.image ?? ""),
//                        content: { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                        }, placeholder: {
//                            Color.gray
//                        })
//                    .frame(width: 170, height: 210)
//                    .mask(RoundedRectangle(cornerRadius: 16))
//                    
//                    VStack(alignment: .leading, spacing: 4.0) {
//                        Text(productData.name ?? "")
//                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
//                        Text(productData.brandName ?? "")
//                            .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
//                        //                        productData.size?.count ?? 0 > 0 ? nil : Text("Free size")
//                        //                            .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
//                        Int(productData.priceOffer) ?? 0 < 0 ? nil : (Text(productData.priceOffer)
//                            .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
//                            .strikethrough()
//                            .foregroundColor(.black50)
//                        )
//                        Text("\(productData.price)")
//                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 14))
//                        Spacer()
//                        VStack() {
//                            Button(currentSize) {
//                                
//                            }
//                            .frame(width: abs(screenSize.width / 2), height: 32, alignment: .leading)
//                            .padding(.leading, 10)
//                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 10))
//                            .foregroundColor(.primaryBlue)
//                            .overlay(
//                                Image("forward")
//                                    .resizable()
//                                    .frame(width: 10, height: 10)
//                                    .padding(.trailing, 10),
//                                alignment: .trailing
//                            )
//                        }
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 4)
//                            .inset(by: 0.5)
//                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
//                        )
//                        Spacer().frame(height: 16)
//                        HStack() {
//                            Button {
//                                
//                            } label: {
//                                Image("apple")
//                            }
//                            .frame(width: abs(screenSize.width / 4.4), height: 32)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8.0)
//                                    .stroke(Color.init(hex: "#E8E9EC", alpha: 1.0), lineWidth: 1)
//                            )
//                            Spacer()
//                            Button("Add to bag") {
//                                
//                            }
//                            .frame(width: abs(screenSize.width / 4.4), height: 32)
//                            .background(currentSize == "Choose Size" ? .gray100 : .primaryBlue)
//                            .foregroundColor(.white)
//                            .font(.custom(getPoppinsFont(weight: .SemiBold), size: 10))
//                            .cornerRadius(8.0)
//                        }
//                        .padding(.trailing, 16.0)
//                        .frame(height: 32)
//                    }
//                }
//                .frame(height: 210)
//            }
//        }
//    }
//}
//
//#Preview {
//    WishlistProductView(productData: addProduct())
//}
