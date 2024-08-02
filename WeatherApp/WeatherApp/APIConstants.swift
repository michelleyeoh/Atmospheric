//
//  APIConstants.swift
//  WeatherApp
//
//  Created by Michelle Yeoh on 7/31/24.
//

import Foundation

enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = "59e36464c6bc44ebac21e84d7a6b295f"
    static let clientSecret = "ddeb7ce24c134c7f854ec0192372fda3"
    static let redirectUri = "https://google.com"
    static let responseType = "token"
    static let scopes = "playlist-modify-public playlist-modify-private"
       
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "redirect_uri": redirectUri,
        "scope": scopes
    ]
}
