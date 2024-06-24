//
//  SimilarMovieCollectionView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import UIKit

final class SimilarMovieCollectionView: UICollectionView {
    
    var similarMovieList = [MoviePosterEntity]() {
        didSet {
            self.reloadData()
        }
    }
    
    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        
        self.delegate = self
        self.dataSource = self
        self.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimilarMovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.similarMovieList[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.reusableIdentifier, for: indexPath) as? SimilarMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(imageURL: movie.posterImage)
        return cell
    }
}
