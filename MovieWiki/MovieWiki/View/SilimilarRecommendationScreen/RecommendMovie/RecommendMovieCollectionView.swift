//
//  RecommendMovieCollectionView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import UIKit

final class RecommendMovieCollectionView: UICollectionView {
    
    var recommendMovieList = [MoviePosterEntity]() {
        didSet {
            self.reloadData()
        }
    }
    
    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.delegate = self
        self.dataSource = self
        self.register(RecommendMovieCollectionViewCell.self, forCellWithReuseIdentifier: RecommendMovieCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendMovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.recommendMovieList[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendMovieCollectionViewCell.reusableIdentifier, for: indexPath) as? RecommendMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(imageURL: movie.posterImage)
        return cell
    }
    
}
