//
//  SimilarMovieCollectionViewCell.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureCellData(imageURL: String) {
        let url = URL(string: API.imageURL(imagePath: imageURL))
        
        self.posterImageView.kf.setImage(with: url)
    }
}
