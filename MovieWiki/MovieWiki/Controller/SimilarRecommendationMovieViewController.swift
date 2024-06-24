//
//  SimilarRecommendationMovieViewController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/24/24.
//

import UIKit
import Combine

class SimilarRecommendationMovieViewController: UIViewController {
    
    private let rootView = SimilarRecommendationMovieView()
    private let model = SilimarRecommendationModel()
    private var cancellable = Set<AnyCancellable>()
    
    init(movieID: Int, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
        self.model.searchQuery = movieID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        self.configureNavigationBackButton()
        self.observeModel()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureNavigationBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }

}

//MARK: - User Action Handling
extension SimilarRecommendationMovieViewController {
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Observing Model
extension SimilarRecommendationMovieViewController {
    private func observeModel() {
        self.model.$similarMovieList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.rootView.update(similarMovieList: new.results)
            }
            .store(in: &cancellable)
        
        self.model.$recommendMovieList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.rootView.update(recommendMovieList: new.results)
            }
            .store(in: &cancellable)
    }
}

