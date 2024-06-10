//
//  CreditEntity.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

struct CreditEntity: Codable {
    let cast: [Actor]
}

struct Actor: Codable {
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath = "profile_path"
    }
}
