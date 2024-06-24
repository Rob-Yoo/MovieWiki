//
//  SearchMovie.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

struct MoviePosterEntity: Codable {
    let posterImage: String
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "poster_path"
        case id
        case title = "original_title"
    }
}
