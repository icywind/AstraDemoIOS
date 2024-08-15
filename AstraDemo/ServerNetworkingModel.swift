//
//  ServerNetworkingModel.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/14/24.
//

import Foundation

/// ==========================================================
/// MARK : Request Models
///
struct AgoraRTCTokenRequest : Codable {
    var requestId: String
    var channelName: String
    var uid : UInt
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
        case uid
    }
}

struct ServiceStartRequest: Codable {
    let requestId: String
    let channelName: String
    let agoraAsrLanguage: String?
    let openaiProxyUrl: String?
    let remoteStreamId: UInt
    let voiceType: String

    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
        case agoraAsrLanguage = "agora_asr_language"
        case openaiProxyUrl = "openai_proxy_url"
        case remoteStreamId = "remote_stream_id"
        case voiceType = "voice_type"
    }
}

struct ServiceStopRequest : Codable {
    let requestId: String
    let channelName: String
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
    }
}

struct ServicePingRequest : Codable {
    let requestId: String
    let channelName: String
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
    }
}

/// ==========================================================
/// MARK : Response Models
///
/// A Codable struct representing the token server response.
struct AgoraRTCTokenResponse: Codable {
    let code: String
    let data: TokenDataClass
    let msg: String
}

struct TokenDataClass: Codable {
    let appId: String
    let channelName: String
    let token: String
    let uid: UInt

    enum CodingKeys: String, CodingKey {
        case appId
        case channelName = "channel_name"
        case token
        case uid
    }
}

