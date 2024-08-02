//
//  APIService.swift
//  WeatherApp
//
//  Created by Michelle Yeoh on 7/31/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    func createPlaylist(userId: String, completion: @escaping (Result<Playlist, Error>) -> Void) {
            guard let token = UserDefaults.standard.string(forKey: "Authorization") else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No access token available"])))
                return
            }
            
            let url = URL(string: "https://api.spotify.com/v1/users/\(userId)/playlists")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "name": "Beat the Clouds",
                "description": "Atmospheric Playlist",
                "public": false
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let playlist = try JSONDecoder().decode(Playlist.self, from: data)
                    completion(.success(playlist))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
//    func createURLRequest() -> URLRequest? {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/search"
//        
//        components.queryItems = [
//            URLQueryItem(name: "type", value: "track"),
//            URLQueryItem(name: "query", value: "bad bunny")
//        ]
//        
//        guard let url = components.url else { return nil }
//        
//        var urlRequest = URLRequest(url: url)
//        
//        let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
//        
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        urlRequest.httpMethod = "GET"
//        
//        return urlRequest
//    }
    
//    func search() async throws -> [String] {
//        guard let urlRequest = createURLRequest() else { throw NetworkError.invalidURL }
//        
//        let (data, _) = try await URLSession.shared.data(for: urlRequest)
//        
//        let decoder = JSONDecoder()
//        let results = try decoder.decode(Response.self, from: data)
//        
//        let items = results.tracks.items
//     
//        let songs = items.map({$0.name})
//        return songs
//    }
    
    
}
struct Playlist: Decodable {
    let id: String
    let name: String
    let description: String
}

//struct Response: Codable {
//    let tracks: Track
//}
//
//struct Track: Codable {
//    let items: [Item]
//}
//
//struct Item: Codable {
//    let name: String
//}
