//
//  NetworkManager.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import Foundation
import Alamofire

struct NetworkManager {
    static func requestURL<T: Codable>(url: String, success: @escaping (_ value: T) -> Void, failure: @escaping (_ error: Error) -> Void = { error in print(error) }) {
        AF.request(url)
            .responseDecodable(of: T.self) { res in
                switch res.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    failure(error)
                }
            }
    }
}
