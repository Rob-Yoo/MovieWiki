//
//  MovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation
import Combine

final class WeeklyTrendMovieModel: MovieModelProtocol {
    @Published var movieList: MovieResult<WeeklyTrendMovie>
    
    init() {
        self.movieList = MovieResult(results: [], totalPages: 1)
        self.fetchMovieData(req: .trendingMovie)
    }
}
