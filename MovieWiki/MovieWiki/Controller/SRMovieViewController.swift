//
//  SRMovieViewController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import Combine

final class SRMovieViewController: UIViewController {
    
    private let rootView = SRTableView()
    private let model = SRModel()
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
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeModel()
    }
}

extension SRMovieViewController {
    private func observeModel() {
        self.model.$moviePosterList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
//                print(new)
                self?.rootView.moviePosterList = new
            }
            .store(in: &cancellable)
    }
}
