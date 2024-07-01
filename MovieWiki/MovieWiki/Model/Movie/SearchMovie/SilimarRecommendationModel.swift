//
//  SilimarRecommendationModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import Foundation
import Combine

final class SilimarRecommendationModel {
    @Published var similarMovieList = MovieResult<MoviePosterEntity>(results: [], totalPages: 0)
    
    @Published var recommendMovieList = MovieResult<MoviePosterEntity>(results: [], totalPages: 0)
    
    var searchQuery = 0 {
        willSet {
            self.fetchSimliarMovieList(movieID: newValue)
            self.fetchRecommendMovieList(movieID: newValue)
        }
    }
}


//MARK: - Model Manipulation
extension SilimarRecommendationModel {
    private func fetchSimliarMovieList(movieID: Int, isAppend: Bool = false) {
        NetworkManager.requestURL(req: .similarMovie(movieID: movieID)) { [weak self] (movieList: MovieResult<MoviePosterEntity>) in
                self?.similarMovieList = movieList
        }
    }
    
    private func fetchRecommendMovieList(movieID: Int, isAppend: Bool = false) {
        NetworkManager.requestURL(req: .recommendMovie(moiveID: movieID)) { [weak self] (movieList: MovieResult<MoviePosterEntity>) in
                self?.recommendMovieList = movieList
        }
    }
}
