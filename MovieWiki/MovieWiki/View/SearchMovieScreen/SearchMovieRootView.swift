//
//  SearchMovieRootView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

protocol SearchMovieRootViewDelegate: AnyObject {
    func searchButtonTapped(query: String)
}

final class SearchMovieRootView: UIView {
    
    private let searchBar = UISearchBar().then {
        $0.placeholder = "영화 제목을 검색해보세요."
        $0.searchBarStyle = .minimal
    }
    
     let searchResultCollectionView = SearchResultCollectionView(frame: .zero) {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40) / 3
        let height = width * 1.3

        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        return layout
    }
    
    weak var searchMovieRootViewDelegate: SearchMovieRootViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.searchBar.delegate = self
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure Subviews
extension SearchMovieRootView {
    private func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(searchResultCollectionView)
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension SearchMovieRootView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let delegate = searchMovieRootViewDelegate else { fatalError("Delegate 지정 해주세요") }
        
        delegate.searchButtonTapped(query: searchBar.text ?? "")
        self.endEditing(true)
    }
}

//MARK: - Update Subviews
extension SearchMovieRootView {
    func update(movieList: [MoviePosterEntity]) {
        self.searchResultCollectionView.movieList = movieList
    }
}
