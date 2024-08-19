//
//  AppConfig.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import Foundation
import SwiftUI

public struct AppConfig: Codable {
    static var shared: AppConfig = {
        guard let fileUrl = Bundle.main.url(forResource: "config", withExtension: "json"),
              let jsonData  = try? Data(contentsOf: fileUrl) else { fatalError() }

        let decoder = JSONDecoder()
        // For this sample code we can assume the json is a valid format.
        // swiftlint:disable:next force_try
        var obj = try! decoder.decode(AppConfig.self, from: jsonData)
        if (obj.rtcToken ?? "").isEmpty {
            obj.rtcToken = nil
        }
        if (obj.openaiProxyUrl ?? "").isEmpty {
            obj.openaiProxyUrl = nil
        }
        return obj
    }()

    var remoteStreamId: UInt
    
    var agoraAsrLanguage: String
    var openaiProxyUrl: String?
    var voiceType: VoiceType

    var uid: UInt
    // APP ID from https://console.agora.io
    var appId: String
    /// Channel prefil text to join
    var channel: String
    /// Rtc token
    var rtcToken: String?
    /// Choose product type from "rtc", "ilr", "voice". See ``RtcProducts``.
    var product: RtcProducts
    /// The base URL of the server
    var serverBaseURL : String
}

enum RtcProducts: String, CaseIterable, Codable {
    case rtc
    case ils
    case voice
    var description: String {
        switch self {
        case .rtc: return "Video Calling"
        case .ils: return "Interactive Live Streaming"
        case .voice: return "Voice Calling"
        }
    }
}

enum VoiceType : String, Codable {
    case male
    case female
    var description: String {
        switch self {
        case .male: return "male"
        case .female: return "female"
        }
    }
}
