//
//  String+Extension.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import Foundation

extension String {
    static let inputFormatter = DateFormatter()
    static let outputFormatter = DateFormatter()

    func formatDate(inputDateFormat: String, outputDateFormat: String, isKorean: Bool = false) -> String? {
        String.inputFormatter.dateFormat = inputDateFormat
        
        guard let dateString = String.inputFormatter.date(from: self) else {
            return nil
        }
        
        String.outputFormatter.dateFormat = outputDateFormat
        if (isKorean) { String.outputFormatter.locale = Locale(identifier:"ko_KR") }
        return String.outputFormatter.string(from: dateString)
    }
}
