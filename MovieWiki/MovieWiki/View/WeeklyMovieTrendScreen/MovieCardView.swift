//
//  MovieCardView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class MovieCardView: UIView {
    
    private let backdropImageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private let castingLabel = UILabel().then {
        $0.textColor = .systemGray2
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let ratingLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10)
    }
    
    init(movie: Movie) {
        super.init(frame: .zero)

        let backdropPath: String = movie.backdropPath
        let rating: Float = movie.rating
        let title: String = movie.title
        
        NetworkManager.requestURL(url: API.creditURL(movieID: String(movie.id))) { [weak self] (credit: CreditEntity) in
            DispatchQueue.main.async {
                self?.castingLabel.text = credit.cast.reduce("") {
                    $0.isEmpty ? $0 + $1.name : $0 + ", " + $1.name
                }
            }
        }
        
        let url = URL(string: API.imageURL(imagePath: backdropPath))

        self.backdropImageView.kf.setImage(with: url)
        self.titleLabel.text = title
        self.ratingLabel.text = "평점: " + String(rating)
        
        self.configureMovieCardView()
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure Subviews
extension MovieCardView {
    private func configureMovieCardView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 15
        self.layer.masksToBounds = false
    }
    
    private func configureHierarchy() {
        self.addSubview(backdropImageView)
        self.addSubview(titleLabel)
        self.addSubview(castingLabel)
        self.addSubview(ratingLabel)
    }
    
    private func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        castingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
            make.height.equalTo(titleLabel.snp.height).multipliedBy(0.5)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(castingLabel.snp.bottom).offset(20)
            make.leading.equalTo(castingLabel.snp.leading)
        }
    }
}
