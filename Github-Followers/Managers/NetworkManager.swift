//
//  NetworkManager.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import Foundation

class NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    let baseURL = "https://api.github.com"
    let perPage = 100
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = "\(baseURL)/users/\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete request. Please chech your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid resposne from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }

        }
        
        task.resume()
    }
    
}
