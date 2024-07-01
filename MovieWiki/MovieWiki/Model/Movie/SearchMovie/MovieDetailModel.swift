//
//  SRModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation
import Combine

final class MovieDetailModel {
    @Published var trailerList = [Trailer]()
    @Published var moviePosterList = [[MoviePosterEntity]]()
    
    var searchQuery = 0 {
        willSet {
            self.fetchMovieTrailerList(movieID: newValue)
            self.fetchMoviePosterList(movieID: newValue)
        }
    }
    
    private func fetchMovieTrailerList(movieID: Int) {
        NetworkManager.requestURL(req: .trailer(movieID: movieID)) { [weak self]
            (response: VideoResult) in
            self?.trailerList = response.results
        }
    }
    
    private func fetchMoviePosterList(movieID: Int) {
        var posterImageList = [[MoviePosterEntity]]()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(req: .similarMovie(movieID: movieID)) { (movieList: MovieResult<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(req: .recommendMovie(moiveID: movieID)) { (movieList: MovieResult<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.moviePosterList = posterImageList
        }
    }
}
