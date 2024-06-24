//
//  SearchMovieViewController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import Combine

final class SearchMovieViewController: UIViewController {
    
    private let model = SearchMovieModel()
    private let rootView = SearchMovieRootView()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "영화 검색"
        self.observingModel()
        self.rootView.searchMovieRootViewDelegate = self
        self.rootView.searchResultCollectionView.searchResultCollectionViewDelegate = self
    }

}

//MARK: - User Action Handling
extension SearchMovieViewController: SearchMovieRootViewDelegate, SearchResultCollectionViewDelegate {
    func searchButtonTapped(query: String) {
        self.model.searchingMovie = query
    }
    
    func scrollDown() {
        self.model.page += 1
    }
    
    func selectMovie(id: Int, title: String) {
        let nextVC = SimilarRecommendationMovieViewController(movieID: id, title: title)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - Observing Model
extension SearchMovieViewController {
    private func observingModel() {
        self.model.$movieList
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.rootView.update(movieList: new.results)
            }
            .store(in: &cancellables)
    }
}
