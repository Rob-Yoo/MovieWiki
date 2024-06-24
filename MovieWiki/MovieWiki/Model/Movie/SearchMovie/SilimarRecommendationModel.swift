//
//  SilimarRecommendationModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import Foundation
import Combine

final class SilimarRecommendationModel {
    @Published var similarMovieList = MovieDTO<MoviePosterEntity>(results: [], totalPages: 0)
    
    @Published var recommendMovieList = MovieDTO<MoviePosterEntity>(results: [], totalPages: 0)
    
    var searchQuery = 0 {
        willSet {
            let similarMovieURL = API.similarMovieURL(movieID: newValue, page: 1)
            let recommendMovieURL = API.recommendationMovieURL(movieID: newValue, page: 1)

            self.fetchSimliarMovieList(url: similarMovieURL)
            self.fetchRecommendMovieList(url: recommendMovieURL)
        }
    }
    
    var similarMoviePage = 1 {
        willSet {
            let similarMovieURL = API.similarMovieURL(movieID: self.searchQuery, page: newValue)
            
            self.fetchSimliarMovieList(url: similarMovieURL, isAppend: true)
        }
    }
    
    var recommendMoviePage = 1 {
        willSet {
            let recommendMovieURL = API.recommendationMovieURL(movieID: self.searchQuery, page: newValue)
            
            self.fetchRecommendMovieList(url: recommendMovieURL, isAppend: true)
        }
    }
}


//MARK: - Model Manipulation
extension SilimarRecommendationModel {
    private func fetchSimliarMovieList(url: String, isAppend: Bool = false) {
        NetworkManager.requestURL(url: url) { [weak self] (movieList: MovieDTO<MoviePosterEntity>) in
            if (isAppend) {
                self?.similarMovieList.results.append(contentsOf: movieList.results)
            } else {
                self?.similarMovieList = movieList
            }
        }
    }
    
    private func fetchRecommendMovieList(url: String, isAppend: Bool = false) {
        NetworkManager.requestURL(url: url) { [weak self] (movieList: MovieDTO<MoviePosterEntity>) in
            if (isAppend) {
                self?.recommendMovieList.results.append(contentsOf: movieList.results)
            } else {
                self?.recommendMovieList = movieList
            }
        }
    }
}
