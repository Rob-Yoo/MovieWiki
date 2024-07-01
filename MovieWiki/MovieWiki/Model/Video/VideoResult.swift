//
//  VideoResult.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 7/1/24.
//

import Foundation

struct VideoResult: Codable {
    let results: [Trailer]
}

struct Trailer: Codable {
    let key: String
}
