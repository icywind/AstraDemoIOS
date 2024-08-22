//
//  UtilTestView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import SwiftUI

struct UtilTestView: View {
    @State private var ResultText = "Click me!"
    @ObservedObject public var agoraManager = AgoraManager(appId: AppConfig.shared.appId, role: .broadcaster)
    @State private var msgCount : Int = 0;
    
    enum TestCase : String, CaseIterable {
       case RandomUserID = "RandomUserID",
            RandomChannel = "RandomChannel",
            UUID = "GetUUID",
            TokenGen = "TokenGen",
            Start = "StartServer",
            Stop  = "StopServer",
            Ping  = "PingSession",
            Message = "SendMessage"
    }
    var body: some View {
        VStack {
            Text(ResultText)
            
            let columns = Array(repeating: GridItem(.flexible()), count: 2)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(TestCase.allCases, id: \.self) { index in
                    Button(action: {
                        HandleButtonCall(index: index)
                    } ) {
                        Text(index.rawValue)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
    
    func HandleTokenResponse (data: Data) -> Void {
        do {
//            if let str = String(data: data, encoding: .utf8) {
//                print("Successfully decoded: \(str)")
//            }

            let tokenResponse = try JSONDecoder().decode(AgoraRTCTokenResponse.self, from: data)
            print(tokenResponse)
        } catch {
            print("token retrieval failed!")
        }
    }
    
    func HandleButtonCall(index: TestCase) -> Void {
        switch(index) {
        case .RandomUserID:
            ResultText = String(getRandomUserId())
            break;
        case .RandomChannel:
            AppConfig.shared.channel = String(getRandomChannel())
            ResultText = AppConfig.shared.channel
            break;
        case .UUID:
            ResultText = String(genUUID())
            print(ResultText)
            break;
        case .TokenGen:
            Task {
                do {
                    let token = try await NetworkManager.ApiRequestToken()
                    print("token = \(token)")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            break;
        case .Start:
            Task {
                let _ = try await NetworkManager.ApiRequestStartService()
                
            }
            break;
        case .Stop:
            Task {
                let _ = try await NetworkManager.ApiRequestStopService()
            }
            break;
        case .Ping:
            Task {
                let _ = try await NetworkManager.ApiRequestPingService()
            }
            break;
        case .Message:
            Task {
                msgCount += 1
                let _ = await agoraManager.startSession(withAI: false)
                let msg = "Message " + String(msgCount)
                agoraManager.sendMessage(message: msg)
                let _ = agoraManager.stopSession()
            }
            break;
        }
    }
}

#Preview {
    UtilTestView()
}
