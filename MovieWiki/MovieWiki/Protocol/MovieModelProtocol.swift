//
//  MovieModelProtocol.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

protocol MovieModelProtocol: AnyObject {
    associatedtype T: Codable
    
    var movieList: MovieDTO<T> { get set }
}

extension MovieModelProtocol {
    func fetchMovieData(req: TMDBRequest, isAppend: Bool = false) {
        NetworkManager.requestURL(req: req) { [weak self] (movieList: MovieDTO<T>) in
            if (isAppend) {
                self?.movieList.results.append(contentsOf: movieList.results)
            } else {
                self?.movieList = movieList                
            }
        }
    }
}
