//
//  MoviePosterCollectionView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit

final class MoviePosterCollectionView: UICollectionView {
    
    var posterImageList = [MoviePosterEntity]() {
        didSet {
            self.reloadData()
        }
    }
    
    init(layout: () -> UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.delegate = self
        self.dataSource = self
        self.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: MoviePosterCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MoviePosterCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posterImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let posterImage = self.posterImageList[indexPath.row].posterImage
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCollectionViewCell.reusableIdentifier, for: indexPath) as? MoviePosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(imageURL: posterImage)
        return cell
    }
}
