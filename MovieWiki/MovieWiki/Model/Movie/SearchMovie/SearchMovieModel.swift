//
//  SearchMovieModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Combine
import Foundation

class SearchMovieModel: MovieModelProtocol {
    @Published var movieList: MovieResult<MoviePosterEntity> = MovieResult(results: [], totalPages: 1)
    var searchingMovie = "" {
        willSet {
            self.fetchMovieData(req: .searchMovie(query: newValue, page: 1))
        }
    }

    var page = 1 {
        willSet {
            if page <= self.movieList.totalPages {
                self.fetchMovieData(req: .searchMovie(query: searchingMovie, page: newValue), isAppend: true)
            }
        }
    }
}

