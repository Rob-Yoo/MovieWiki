//
//  MovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation
import Combine

final class WeeklyTrendMovieModel: MovieModelProtocol {
    @Published var movieList: MovieDTO<WeeklyTrendMovie>
    
    init() {
        self.movieList = MovieDTO(results: [], totalPages: 1)
        self.fetchMovieData(url: API.weeklyTrendMovieURL)
    }
}
