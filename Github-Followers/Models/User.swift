//
//  User.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import Foundation

struct User: Codable {
    
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: String
    var followers: String
    var createdAt: String
    
}
