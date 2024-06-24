//
//  SearchMovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Combine
import Foundation

class SearchMovieModel: MovieModelProtocol {
    @Published var movieList: MovieDTO<MoviePosterEntity> = MovieDTO(results: [], totalPages: 1)
    var searchingMovie = "" {
        willSet {
            let url = API.searchMovieURL(movie: newValue, page: 1)
            self.fetchMovieData(url: url)
        }
    }

    var page = 1 {
        willSet {
            if page <= self.movieList.totalPages {
                let url = API.searchMovieURL(movie: self.searchingMovie, page: newValue)
                self.fetchMovieData(url: url, isAppend: true)
            }
        }
    }
}

