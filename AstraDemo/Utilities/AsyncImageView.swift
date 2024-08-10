//
//  AsyncImageView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/9/24.
//
import Foundation
import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage? = nil

    let url: URL?
    init(url: String) {
        self.url = URL(string: url)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Image("agora-icon-logo").resizable().aspectRatio(contentMode: .fit)
                VStack {
                    Text("Your Text")
                        .font(.callout)
                        .foregroundColor(.black)
                }
            }
            Group {
                if let image = self.image {
                    ZStack(alignment: .top) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    ProgressView("Loading...")

                }
            }
        }.padding(10)
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
    }
    

}

#Preview {
    AsyncImageView(url: "https://github.githubassets.com/assets/starstruck-default-b6610abad518.png")
}
