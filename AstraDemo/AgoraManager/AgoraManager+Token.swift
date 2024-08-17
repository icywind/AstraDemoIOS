//
//  AgoraManager+Permissions.swift
//  Docs-Examples
//
//  Created by Max Cobb on 23/08/2023.
//

import Foundation
import AVKit
import AgoraRtcKit

public extension AgoraManager {

    // MARK: - Token Request

    /// Fetches a token from the specified token server URL.
    ///
    /// - Parameters:
    ///   - tokenUrl: The URL of the token server.
    ///   - channel: The name of the channel for which the token will be used.
    ///   - role: The role of the user for which the token will be generated.
    ///   - userId: The ID of the user for which the token will be generated. Defaults to 0.
    ///
    /// - Returns: An optional string containing the RTC token, or `nil` if an error occurred.
    ///
    /// - Throws: An error of type `Error` if an error occurred during the token fetching process.
    func fetchToken(
        from tokenUrl: String, channel: String,
        role: AgoraClientRole, userId: UInt = 0
    ) async throws -> String {
        guard let url = URL(string: "\(tokenUrl)/getToken") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let userData = [
            "tokenType": "rtc",
            "uid": String(userId),
            "role": role == .broadcaster ? "publisher" : "subscriber",
            "channel": channel
        ]

        let requestData = try JSONEncoder().encode(userData)
        request.httpBody = requestData

        let (data, _) = try await URLSession.shared.data(for: request)
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)

        return tokenResponse.token
    }

    /// A Codable struct representing the token server response.
    struct TokenResponse: Codable {
        /// Value of the RTC Token.
        public let token: String
    }

    // MARK: - Agora Engine Functions

    /// Fetch a token from the token server, and then join the channel using Agora SDK.
    /// - Returns: A boolean, for whether or not the token fetching was successful.
    /// - Parameters:
    ///   - tokenUrl: The URL of the token server.
    ///   - channel: The name of the channel for which the token will be used.
    fileprivate func fetchTokenThenJoin(tokenUrl: String, channel: String) async -> Bool {
        if let token = try? await self.fetchToken(
            from: tokenUrl, channel: channel,
            role: role, userId: 0
        ) {
            return await self.joinChannel(
                channel, token: token, uid: 0
            ) == 0
        } else { return false }
    }

    // MARK: - Delegate Methods

    func rtcEngine(
        _ engine: AgoraRtcEngineKit, tokenPrivilegeWillExpire token: String
    ) {
        Task {
            do {
                let newToken = try await NetworkManager.ApiRequestToken()
                print("token = \(token) renewed = \(newToken)")
                self.agoraEngine.renewToken(newToken)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
