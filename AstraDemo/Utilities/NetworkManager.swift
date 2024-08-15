//
//  NetworkManager.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import Foundation

let REQUEST_URL = "http://localhost:8080"

struct GenAgoraDataConfig: Codable {
    let userId: UInt
    let channel: String
}

open class NetworkManager {
    
    /// Description
    /// - Parameters:
    ///   - config: required configuration data (uid, channel_name, and a request_id)
    ///   - completion: clousure to handle the request result as Data and Error pair
    static func ApiRequestToken(completion: @escaping (Result<Data, Error>) -> Void) {
        let config = AppConfig.shared;
        let data = AgoraRTCTokenRequest(requestId: genUUID(),
                                        channelName: config.channel,
                                        uid: config.uid)
        ServerApiRequest(apiurl: "\(REQUEST_URL)/token/generate", data: data, completion: completion)
    }
    
    static func ApiRequestStartService(completion: @escaping (Result<Data, Error>) -> Void) {
        let config = AppConfig.shared;
        let data = ServiceStartRequest(requestId: genUUID(),
                                       channelName: config.channel,
                                       agoraAsrLanguage: config.agoraAsrLanguage,
                                       openaiProxyUrl: config.openaiProxyUrl,
                                       remoteStreamId: config.uid,
                                       voiceType: config.voiceType.description)
        ServerApiRequest(apiurl: "\(REQUEST_URL)/start", data: data, completion: completion)
    }
    
    static func ApiRequestStopService(completion: @escaping (Result<Data, Error>) -> Void) {
        let config = AppConfig.shared;
        let data = ServiceStopRequest(requestId: genUUID(),
                                        channelName: config.channel)
        ServerApiRequest(apiurl: "\(REQUEST_URL)/stop", data: data, completion: completion)
    }
    
    static func ApiRequestPingService(completion: @escaping (Result<Data, Error>) -> Void) {
        let config = AppConfig.shared;
        let data = ServicePingRequest(requestId: genUUID(),
                                        channelName: config.channel)
        ServerApiRequest(apiurl: "\(REQUEST_URL)/ping", data: data, completion: completion)
    }
    
    private static func ServerApiRequest(apiurl:String, data: Codable, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string:apiurl)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(data)
        } catch {
            print("Failed to serialize data: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if let str = String(data: data, encoding: .utf8) {
                    print("Successfully decoded: \(str)")
                }
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
