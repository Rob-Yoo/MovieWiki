//
//  MovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation
import Combine

final class WeeklyTrendingMovieModel {
    @Published var movieList: WeeklyTrendingMovieEntity
    
    init() {
        self.movieList = WeeklyTrendingMovieEntity(results: [])
        self.fetchWeeklyTrendingMovies()
    }
    
    func fetchWeeklyTrendingMovies() {
        let url = API.weeklyTrendMovieURL
        
        NetworkManager.requestURL(url: url) { [weak self] (movieList: WeeklyTrendingMovieEntity) in
            self?.movieList = movieList
        }
    }
}
