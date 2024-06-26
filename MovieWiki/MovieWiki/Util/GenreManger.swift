//
//  GenreManger.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation

final class GenreManger {
    static let shared = GenreManger()
    private var genres: [Genre] = []
    
    private init() {
        NetworkManager.requestURL(req: .genre) { (entity: GenreEntity) in
            self.genres = entity.genres
        }
    }
    
    func convertIdIntoName(genreIDs: [Int]) -> [String] {
        return genreIDs.map { id in
            genres.first { $0.id == id }?.name ?? ""
        }
    }
}
