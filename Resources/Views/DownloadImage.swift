//
//  DownloadImage.swift
//  BANOUN
//
//  Created by Mobilions iOS on 16/01/24.
//

import SwiftUI

struct DownloadImage: View {
    @State var imgUrl = String()
    @State var width = CGFloat()
    @State var height = CGFloat()
    @State var cornerRadius: CGFloat = 0
    @State var loading: Bool = true
    
    var body: some View {
        ZStack(alignment: .top) {
            
            AsyncImage(
                url: URL(string: imgUrl),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .onAppear {
                            loading = false
                        }
                }, placeholder: {
                    Color.clear
                })
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
            .onAppear {
            }
            .overlay(
                ActivityIndicator(isAnimating: loading)
                    .configure { $0.color = .black }
                    .background(.clear)
            )
        }
    }
}

#Preview {
    DownloadImage()
}

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    var configuration = { (indicator: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
