//
//  UtilTestView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import SwiftUI

struct UtilTestView: View {
    @State private var ResultText = "Click me!"
    enum TestCase : String, CaseIterable {
       case RandomUserID = "RandomUserID",
            RandomChannel = "RandomChannel",
            UUID = "GetUUID",
            TokenGen = "TokenGen",
            Start = "StartServer",
            Stop  = "StopServer",
            Ping  = "PingSession"
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
            ResultText = String(getRandomChannel())
            break;
        case .UUID:
            ResultText = String(genUUID())
            print(ResultText)
            break;
        case .TokenGen:
            NetworkManager.ApiRequestToken() {
                  result in
                    switch result {
                    case .success(let data):
                        // Handle the success case
                        print("Data received: \(data)")
                        HandleTokenResponse(data: data)
                    case .failure(let error):
                        // Handle the error case
                        print("Error occurred: \(error.localizedDescription)")
                        // You can handle the error here
                    }
                }
            break;
        case .Start:
            NetworkManager.ApiRequestStartService() {
                result in
                switch result {
                case .success(let data):
                    // Handle the success case
                    print("Data received: \(data)")
                    
                case .failure(let error):
                    // Handle the error case
                    print("Error occurred: \(error.localizedDescription)")
                }
            }
            break;
        case .Stop:
            NetworkManager.ApiRequestStopService() {
                result in
                switch result {
                case .success(let data):
                    // Handle the success case
                    print("Data received: \(data)")
                    
                case .failure(let error):
                    // Handle the error case
                    print("Error occurred: \(error.localizedDescription)")
                }
            }
            break;
        case .Ping:
            NetworkManager.ApiRequestPingService() {
                result in
                switch result {
                case .success(let data):
                    // Handle the success case
                    print("Data received: \(data)")
                    
                case .failure(let error):
                    // Handle the error case
                    print("Error occurred: \(error.localizedDescription)")
                }
            }
            break;
        }
    }
}

#Preview {
    UtilTestView()
}
