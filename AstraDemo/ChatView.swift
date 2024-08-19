//
//  ChatView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/9/24.
//

import SwiftUI

struct ChatView: View {
    @State var _preview = false
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(channelId: String) {
        AppConfig.shared.channel = channelId
        if (channelId == "preview") {
            _preview = true
        }
    }
    
    @ObservedObject public var agoraManager = AgoraManager(appId: AppConfig.shared.appId, role: .broadcaster)

    public var body: some View {
        // Show a scrollable view of video feeds for all participants.
        ZStack {
            ScrollView {
                Text("Channel:" + AppConfig.shared.channel).padding(20)
                VStack {
                    // Show the video feeds for each participant.
                    ForEach(Array(agoraManager.allUsers), id: \.self) { uid in
                        Group {
                            if let pub = agoraManager.userVideoPublishing[uid] {
                                if (pub) {
                                    AgoraVideoCanvasView(manager: agoraManager, uid: uid)
                                        .aspectRatio(contentMode: .fit).cornerRadius(10)
                                } else {
                                    PlaceHolderUserView(user: uid)
                                }
                            } else {
                                // Placeholder
                                PlaceHolderUserView(user: uid)
                            }
                        }
                    }
                }.padding(20)
            }.background(Color.cyan)
            ToastView(message: $agoraManager.label)
                .onReceive(timer) { time in
                    print("The time is now \(time)")
                    agoraManager.pingSession()
                }
        }.onAppear { // Note this onAppear is an async extension
            await agoraManager.startSession()
        }.onDisappear {
            timer.upstream.connect().cancel()
            agoraManager.stopSession()
        }
    }
}

#Preview {
   ChatView(channelId: "preview")
}
