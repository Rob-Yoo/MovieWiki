//
//  MovieModelProtocol.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

protocol MovieModelProtocol: AnyObject {
    associatedtype T: Codable
    
    var movieList: MovieEntity<T> { get set }
}

extension MovieModelProtocol {
    func fetchMovieData(url: String, isAppend: Bool = false) {
        NetworkManager.requestURL(url: url) { [weak self] (movieList: MovieEntity<T>) in
            if (isAppend) {
                self?.movieList.results.append(contentsOf: movieList.results)
            } else {
                self?.movieList = movieList                
            }
        }
    }
}
