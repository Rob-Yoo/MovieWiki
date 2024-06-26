//
//  SearchResultCollectionViewCell.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        self.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellData(imagePath: String) {
        let urlString = TMDBRequest.image(imagePath: imagePath).endPoint
        let url = URL(string: urlString)
        
        self.posterImageView.kf.setImage(with: url)
    }
}
