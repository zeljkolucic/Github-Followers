//
//  PersistenceError.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 10.3.22..
//

import Foundation

enum PersistenceError: String, Error {
    
    case unableToDecode = "There was an error trying to decode persistent data."
    case unableToEncode = "There was an error trying to encode persistent data."
    case alreadyExists = "This user is already saved in favorites."
    
}
