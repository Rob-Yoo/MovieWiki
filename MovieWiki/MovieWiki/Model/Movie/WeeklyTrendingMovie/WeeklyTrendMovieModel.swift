//
//  MovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation
import Combine

final class WeeklyTrendMovieModel: MovieModelProtocol {
    @Published var movieList: MovieEntity<WeeklyTrendMovie>
    
    init() {
        self.movieList = MovieEntity(results: [], totalPages: 1)
        self.fetchMovieData(url: API.weeklyTrendMovieURL)
    }
}
