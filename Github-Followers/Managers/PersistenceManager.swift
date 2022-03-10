//
//  PersistenceManager.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 10.3.22..
//

import Foundation

enum PersistenceActionType {
    case add
    case remove
}

enum PersistenceManager {
    
    private static let defaults = UserDefaults.standard
    
    enum Key {
        static let favorites = "favorites"
    }
    
    static func update(with favorite: Follower, actionType: PersistenceActionType, completionHandler: @escaping (PersistenceError?) -> Void) {
        retreiveFavorites { result in
            switch result {
            case .success(var retreivedFavorites):
                switch actionType {
                case .add:
                    guard !retreivedFavorites.contains(favorite) else {
                        completionHandler(.alreadyExists)
                        return
                    }
                    
                    retreivedFavorites.append(favorite)
                case .remove:
                    retreivedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completionHandler(save(favorites: retreivedFavorites))
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    static func retreiveFavorites(completionHandler: @escaping (Result<[Follower], PersistenceError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Key.favorites) as? Data else {
            completionHandler(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completionHandler(.success(favorites))
        } catch {
            completionHandler(.failure(.unableToDecode))
        }
    }
    
    static func save(favorites: [Follower]) -> PersistenceError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Key.favorites)
        } catch {
            return .unableToEncode
        }
        
        return nil
    }
    
}
