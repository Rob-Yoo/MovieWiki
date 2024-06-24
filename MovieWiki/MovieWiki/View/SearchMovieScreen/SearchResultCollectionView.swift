//
//  SearchResultCollectionView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

protocol SearchResultCollectionViewDelegate: AnyObject {
    func scrollDown()
    func selectMovie(id: Int, title: String)
}

final class SearchResultCollectionView: UICollectionView {
    
     var movieList = [MoviePosterEntity]() {
        didSet {
            self.reloadData()

            if (oldValue.count > movieList.count && !movieList.isEmpty) {
                self.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    weak var searchResultCollectionViewDelegate: SearchResultCollectionViewDelegate?
    
    init(frame: CGRect, layout : () -> UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout())
        
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.prefetchDataSource = self
        self.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movieList[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCellData(imagePath: movie.posterImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movieList[indexPath.row]
        
        guard let delegate = self.searchResultCollectionViewDelegate else { return }
        
        delegate.selectMovie(id: movie.id, title: movie.title)
    }
}

extension SearchResultCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let delegate = self.searchResultCollectionViewDelegate else { return }

        for indexPath in indexPaths {
            if movieList.count - 2 == indexPath.item {
                delegate.scrollDown()
            }
        }
    }
}
