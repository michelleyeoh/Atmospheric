//
//  ViewController.swift
//  TestSpotifyAuth
//
//  Created by Michelle Yeoh on 8/1/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    private var playlistURL: URL?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            if let token = UserDefaults.standard.value(forKey: "Authorization") {
                
//                makeNetworkCall()
                createPlaylist()
                
            } else {
                getAccessTokenFromWebView()
            }
            
        }
        
        private func getAccessTokenFromWebView() {
            guard let urlRequest = APIService.shared.getAccessTokenURL() else { return }
            let webview = WKWebView()
            
            webview.load(urlRequest)
            webview.navigationDelegate = self
            view = webview
        }
    
    private func createPlaylist() {
            let userId = "myfiercefighter" // Replace with actual user ID
            APIService.shared.createPlaylist(userId: userId) { result in
                switch result {
                case .success(let playlist):
                    print("Playlist created: \(playlist.name)")
                    self.playlistURL = URL(string: "https://open.spotify.com/playlist/\(playlist.id)")
                                        self.openPlaylist()
                case .failure(let error):
                    print("Failed to create playlist: \(error.localizedDescription)")
                }
            }
        }
    private func openPlaylist() {
            guard let url = playlistURL else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

//        private func makeNetworkCall() {
//            Task {
//                let songs = try await APIService.shared.search()
//                print(songs)
//            }
//        }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else { return }
        print(urlString)
        
        var tokenString = ""
        if urlString.contains("#access_token=") {
            let range = urlString.range(of: "#access_token=")
            guard let index = range?.upperBound else { return }
            
            tokenString = String(urlString[index...])
        }
        
        if !tokenString.isEmpty {
            let range = tokenString.range(of: "&token_type=Bearer")
            guard let index = range?.lowerBound else { return }
            
            tokenString = String(tokenString[..<index])
            UserDefaults.standard.setValue(tokenString, forKey: "Authorization")
            webView.removeFromSuperview()
//            print(tokenString)
//            makeNetworkCall()
            createPlaylist()
        }
        
    }
}
