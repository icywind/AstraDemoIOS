//
//  ContentView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/8/24.
//

import SwiftUI

struct ContentView: View {
    /// The user inputted `channelId` string.
    @State var channelId: String = AppConfig.shared.channel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter text", text: $channelId)
                    .padding()
                    .border(Color.gray, width: 0.5)

                HStack {
                    NavigationLink(destination:
                                    ChatView(channelId: channelId)) {
                        Text("Join")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination:
                                    AsyncImageView(url: "")) {
                        Text("Image")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination:
                                   UtilTestView()) {
                        Text("Util")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
