//
//  TMDBRequest.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trendingMovie
    case genre
    case image(imagePath: String)
    case credit(movieID: Int)
    case searchMovie(query: String, page: Int)
    case similarMovie(movieID: Int)
    case recommendMovie(moiveID: Int)
    case trailer(movieID: Int)
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var endPoint: String {
        switch self {
        case .trendingMovie:
            return self.baseURL + "/trending/movie/week"
        case .genre:
            return self.baseURL + "/genre/movie/list"
        case .image(let imagePath):
            return "https://image.tmdb.org/t/p/w780" + imagePath
        case .credit(let movieID):
            return self.baseURL + "/movie/\(movieID)/credits"
        case .searchMovie(_, _):
            return self.baseURL + "/search/movie"
        case .similarMovie(let movieID):
            return self.baseURL + "/movie/\(movieID)/similar"
        case .recommendMovie(let movieID):
            return self.baseURL + "/movie/\(movieID)/recommendations"
        case .trailer(let movieID):
            return self.baseURL + "/movie/\(movieID)/videos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .searchMovie(let query, let page):
            return ["language": "ko-KR", "query": query, "page": page, "include_adult": false]
        case .image(_):
            return [:]
        case .similarMovie(_):
            return ["language": "ko-KR", "page": 1]
        case .recommendMovie(_):
            return ["language": "ko-KR", "page": 1]
        case .genre:
            return ["language": "ko"]
        case .trailer(_):
            return ["language": "en-US"]
        default:
            return ["language": "ko-KR"]
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": API.apiKey, "accept": "application/json"]
    }
}
