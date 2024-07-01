//
//  ViewController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/10/24.
//

import UIKit
import Combine

final class WeeklyMovieTrendViewController: UIViewController {

    private let model = WeeklyTrendMovieModel()
    private let rootView = WeeklyMovieTrendRootView()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.view.backgroundColor = .white
        self.observingModel()
    }

    private func configureNavigationBar() {
        let style = UINavigationBarAppearance()
        
        style.shadowColor = UIColor.lightGray
        self.navigationController?.navigationBar.standardAppearance = style
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
}

//MARK: - User Action Handling
extension WeeklyMovieTrendViewController {
    @objc func searchButtonTapped() {
        let nextVC = SearchMovieViewController()
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - Observing Model
extension WeeklyMovieTrendViewController {
    private func observingModel() {
        self.model.$movieList
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.rootView.update(movieData: new)
            }
            .store(in: &cancellables)
    }
}

