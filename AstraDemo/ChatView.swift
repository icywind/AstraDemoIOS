//
//  ChatView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/9/24.
//

import SwiftUI

struct ChatView: View {
    @State var _preview = false
    
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
        }.onAppear { // Note this onAppear is an async extension
            let channel = AppConfig.shared.channel
            var token = AppConfig.shared.rtcToken;
            
            // if intended AppID is token-enable, then the config file should
            // has one non empty entry (copied from console)
            // We will use the server generated version to avoid manual entry
            // from now on.
            if (token != nil && token != "") {
                do {
                    token = try await NetworkManager.ApiRequestToken()
                } catch let error {
                    print("ApiRequestToken:\(error)")
                    return
                }
            }
            let uid = AppConfig.shared.uid
            switch AppConfig.shared.product {
            case .rtc:
                await agoraManager.joinVideoCall(channel, token: token, uid: uid)
            case .ils:
                await agoraManager.joinBroadcastStream(
                    channel, token: token, uid: uid,
                    isBroadcaster: true
                )
            case .voice:
                await agoraManager.joinVoiceCall(channel, token: token, uid: uid)
            }
        }.onDisappear {
            agoraManager.leaveChannel(leaveChannelBlock: nil, destroyInstance: false)
        }
    }
}

#Preview {
   ChatView(channelId: "preview")
}
