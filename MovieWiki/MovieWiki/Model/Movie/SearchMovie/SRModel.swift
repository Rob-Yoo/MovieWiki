//
//  SRModel.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation
import Combine

final class SRModel {
    @Published var moviePosterList = [[MoviePosterEntity]]()
    
    var searchQuery = 0 {
        willSet {
            let similarMovieURL = API.similarMovieURL(movieID: newValue, page: 1)
            let recommendMovieURL = API.recommendationMovieURL(movieID: newValue, page: 1)
            
            self.fetchMoviePosterList(similarURL: similarMovieURL, recommendURL: recommendMovieURL)
        }
    }
    
    private func fetchMoviePosterList(similarURL: String, recommendURL: String) {
        var posterImageList = [[MoviePosterEntity]]()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(url: similarURL) { (movieList: MovieDTO<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(url: recommendURL) { (movieList: MovieDTO<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.moviePosterList = posterImageList
        }
    }
}
