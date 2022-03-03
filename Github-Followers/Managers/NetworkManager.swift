//
//  NetworkManager.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class NetworkManager {
    
    // MARK: Singleton Instance
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private let baseURL = "https://api.github.com"
    private let perPage = 100
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // MARK: Network Calls
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/users/\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData) )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            } catch {
                completionHandler(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    func downloadImage(from endpoint: String, completionHandler: @escaping (UIImage) -> ()) {
        let cacheKey = NSString(string: endpoint)
        
        if let image = cache.object(forKey: cacheKey) {
            completionHandler(image)
            return
        }
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            completionHandler(image)
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData) )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
