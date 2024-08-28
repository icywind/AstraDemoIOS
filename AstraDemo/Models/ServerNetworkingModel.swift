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

struct ServerStartProperties : Codable {
    let agoraRtc : [String:String]
    let openaiChatGPT : [String:String]
    let azureTTS : [String:String]
    enum CodingKeys: String, CodingKey {
        case agoraRtc = "agora_rtc"
        case openaiChatGPT = "openai_chatgpt"
        case azureTTS = "azure_tts"
    }
}

struct ServiceStartRequest: Codable {
    let requestId: String
    let channelName: String
    let openaiProxyUrl: String?
    let remoteStreamId: UInt
    let graphName : String
    let voiceType: String
    let properties : ServerStartProperties

    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
        case openaiProxyUrl = "openai_proxy_url"
        case remoteStreamId = "remote_stream_id"
        case graphName = "graph_name"
        case voiceType = "voice_type"
        case properties = "properties"
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
/// A Codable struct representing the server response for commands like start,stop and ping
struct AgoraServerCommandResponse: Codable {
    let code: String // "0" or error code in ""
    let data: Int    // non-zero if there is an error
    let msg: String  // explains what went wrong if error occurs
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

