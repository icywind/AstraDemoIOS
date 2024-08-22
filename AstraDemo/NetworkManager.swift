//
//  NetworkManager.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import Foundation

open class NetworkManager {
    /// Description - ApiRequestToken
    ///    Request the server to generate a token based on channel and uid.
    ///  The caller should handle the exception from this networking action.
    /// - Returns: rtc token string
    static func ApiRequestToken() async throws -> String {
        let config = AppConfig.shared;
        let data = AgoraRTCTokenRequest(requestId: genUUID(),
                                        channelName: config.channel,
                                        uid: config.uid)
        let endpoint = config.serverBaseURL + "/token/generate"
        let response = try await ServerApiRequest(apiurl:endpoint, data: data)
        let decoded = try JSONDecoder().decode(AgoraRTCTokenResponse.self, from: response)
        return decoded.data.token
    }
    
    static func ApiRequestStartService() async throws -> Data {
        let config = AppConfig.shared;
        let data = ServiceStartRequest(requestId: genUUID(),
                                       channelName: config.channel,
                                       agoraAsrLanguage: config.agoraAsrLanguage,
                                       openaiProxyUrl: config.openaiProxyUrl,
                                       remoteStreamId: config.remoteStreamId,
                                       voiceType: config.voiceType.description)
        let endpoint = config.serverBaseURL + "/start"
        return try await ServerApiRequest(apiurl: endpoint, data: data)
    }
    
    static func ApiRequestStopService() async throws -> Data {
        let config = AppConfig.shared;
        let data = ServiceStopRequest(requestId: genUUID(),
                                      channelName: config.channel)
        let endpoint = config.serverBaseURL + "/stop"
        return try await ServerApiRequest(apiurl: endpoint, data: data)
    }
    
    static func ApiRequestPingService() async throws -> Data {
        let config = AppConfig.shared;
        let data = ServicePingRequest(requestId: genUUID(),
                                      channelName: config.channel)
        let endpoint = config.serverBaseURL + "/ping"
        return try await ServerApiRequest(apiurl: endpoint, data: data)
    }
    
    private static func ServerApiRequest(apiurl:String, data: Codable) async throws -> Data {
        let url = URL(string:apiurl)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            request.httpBody = try JSONEncoder().encode(data)
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { (data1, response, error) in
                if let error = error {
                    continuation.resume(with: .failure(error))
                } else if let data = data1 {
//                    if let str = String(data: data, encoding: .utf8) {
//                        print("Successfully decoded: \(str)")
//                    }
                    continuation.resume(with: .success(data))
                }
            }
            task.resume()
        }
    }
}
