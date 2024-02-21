//
//  ProductView.swift
//  BANOUN
//
//  Created by Mobilions iOS on 16/01/24.
//

import SwiftUI

struct ProductView: View {
    @State var imgUrl = String()
    @State var width = CGFloat()
    @State var height = CGFloat()
    @State var cornerRadius: CGFloat = 0
    @State var loading: Bool = true
    @State var title = String()
    @State var subCategory = String()
    @State var price = String()
    @State var offerPrice: String = ""
    @State var showofferPrice: Bool = true
    @State var isWishlist = "golden_wishlist_bordered"
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                //                AsyncImage(
                //                    url: URL(string: imgUrl),
                //                    content: { image in
                //                        image
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fill)
                //                            .onAppear {
                //                                loading = false
                //                            }
                //                    }, placeholder: {
                //                        Color.clear
                //                    })
                Image(imgUrl)
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .onAppear {
                    }
                    .overlay(
                        Image(isWishlist)
                            .resizable()
                            .padding([.top, .trailing], 5)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                if isWishlist == "golden_wishlist_bordered" {
                                    isWishlist = "golden_wishlist_selected"
                                } else {
                                    isWishlist = "golden_wishlist_bordered"
                                }
                            },
                        alignment: .topTrailing
                    )
                Spacer().frame(height: 12)
                Text(title)
                    .font(.custom(getPoppinsFont(weight: .SemiBold), size: 10))
                    .lineLimit(2)
                Spacer().frame(height: 4)
                Text(subCategory)
                    .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
                    .frame(width: width, alignment: .leading)
                    .lineLimit(2)
                Spacer().frame(height: 8)
                if offerPrice != "" && showofferPrice {
                    HStack() {
                        Text(offerPrice)
                            .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
                            .foregroundColor(.black50)
                            .strikethrough()
                            .frame(width: 60, alignment: .leading)
                        Spacer()
                        Text(price)
                            .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
                            .padding(.trailing, 8)
                    }
                } else {
                    Text(price)
                        .font(.custom(getPoppinsFont(weight: .Regular), size: 12))
                        .frame(width: width, alignment: .leading)
                }
            }
            //            .overlay(
            //                ActivityIndicator(isAnimating: loading)
            //                    .configure { $0.color = .black }
            //                    .background(.clear)
            //            )
        }
    }
}

#Preview {
    ProductView()
}
