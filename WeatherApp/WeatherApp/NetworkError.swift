//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Michelle Yeoh on 7/31/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
}
