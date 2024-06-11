//
//  SearchMovie.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

struct SearchMovie: Codable {
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "poster_path"
    }
}
