//
//  WeeklyTrendMovie.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

struct WeeklyTrendMovie: Codable {
    let backdropPath: String
    let id: Int
    let overview: String
    let posterPath: String
    let title: String
    let genres: [Int]
    let releaseDate: String
    let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case overview
        case posterPath = "poster_path"
        case genres = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}
