//
//  SimilarRecommendationMovieView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import UIKit
import SnapKit
import Then

class SimilarRecommendationMovieView: UIView {
    
    private let similarMovieLabel = UILabel().then {
        $0.text = "비슷한 영화"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let similarMovieCollectionView = SimilarMovieCollectionView {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40) / 3.5
        let height = width * 1.4
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    private let recommendMovieLabel = UILabel().then {
        $0.text = "추천 영화"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let recommendMovieCollectionView = RecommendMovieCollectionView {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40) / 3.5
        let height = width * 1.4
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(similarMovieLabel)
        self.addSubview(similarMovieCollectionView)
        self.addSubview(recommendMovieLabel)
        self.addSubview(recommendMovieCollectionView)
    }
    
    private func configureLayout() {
        similarMovieLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        similarMovieCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarMovieLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        recommendMovieLabel.snp.makeConstraints {
            $0.top.equalTo(similarMovieCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        recommendMovieCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendMovieLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func update(similarMovieList: [MoviePosterEntity]) {
        self.similarMovieCollectionView.similarMovieList = similarMovieList
    }

    func update(recommendMovieList: [MoviePosterEntity]) {
        self.recommendMovieCollectionView.recommendMovieList = recommendMovieList
    }
}
