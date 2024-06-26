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
            self.fetchMoviePosterList(movieID: newValue)
        }
    }
    
    private func fetchMoviePosterList(movieID: Int) {
        var posterImageList = [[MoviePosterEntity]]()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(req: .similarMovie(movieID: movieID)) { (movieList: MovieDTO<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.requestURL(req: .recommendMovie(moiveID: movieID)) { (movieList: MovieDTO<MoviePosterEntity>) in
                posterImageList.append(movieList.results)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.moviePosterList = posterImageList
        }
    }
}
