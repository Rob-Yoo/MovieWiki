//
//  GenreHashTagLabelStackView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import Then

final class GenreHashTagLabelStackView: UIStackView {
    
    private var genres: [String]
    private lazy var genreHashTagLabels: [UILabel] = self.genres.map {
        let genre = $0

        return UILabel().then {
            $0.text = "#" + genre
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    init(genres: [String]) {
        self.genres = genres
        super.init(frame: .zero)
        self.configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 5
        self.genreHashTagLabels.forEach { self.addArrangedSubview($0) }
    }
}
