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
        VStack {
            HStack {
                Text("Channel:").foregroundColor(.black).font(.title)
                Text(AppConfig.shared.channel).foregroundColor(.blue).font(.title)
            }.padding(20)
            let columns = Array(repeating: GridItem(.flexible()), count: 2)
            LazyVGrid(columns: columns, spacing: 20) {
                    // Show the video feeds for each participant.
                    ForEach(Array(agoraManager.allUsers), id: \.self) { uid in
                        Group {
                            if let pub = agoraManager.userVideoPublishing[uid] {
                                if (pub) {
                                    AgoraVideoCanvasView(manager: agoraManager, uid: uid)
                                        .aspectRatio(contentMode: .fit).cornerRadius(10)
                                } else {
                                    PlaceHolderUserView(user: uid).aspectRatio(contentMode: .fit).cornerRadius(10)
                                }
                            } else {
                                // Placeholder
                                PlaceHolderUserView(user: uid).aspectRatio(contentMode: .fit).cornerRadius(10)
                            }
                        }
                    }
            }//.padding(20)
            TranscriptionView(
                messages: agoraManager.messages,
                    speakerA: "Agent",
                    speakerB: "You"
            ).scaledToFit()
            ToastView(message: $agoraManager.label)
            .onReceive(timer) { time in
                if (!_preview) {
                    agoraManager.pingSession()
                }
            }
        }.onAppear { // Note this onAppear is an async extension
            if (!_preview) {
                await agoraManager.startSession(withAI: true)
            }
        }.onDisappear {
            timer.upstream.connect().cancel()
            if (!_preview) {
                agoraManager.stopSession()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
           
    }
}

#Preview {
   ChatView(channelId: "preview")
}
