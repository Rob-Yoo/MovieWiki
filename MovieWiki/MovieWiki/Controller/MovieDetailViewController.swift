//
//  SRMovieViewController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import Combine

final class MovieDetailViewController: UIViewController {
    
    private let rootView = MovieDetailRootView()
    private let model = MovieDetailModel()
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
        self.rootView.simRecmdTableView.delegate = self
        self.rootView.simRecmdTableView.dataSource = self
        self.observeModel()
    }
}

extension MovieDetailViewController {
    private func observeModel() {
        
        self.model.$trailerList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                guard !new.isEmpty else { return }
                
                let key = new[0].key
                let url = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                let urlReq = URLRequest(url: url)
                self?.rootView.movieTrailerView.webView.load(urlReq)
            }
            .store(in: &cancellable)
        
        self.model.$moviePosterList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.rootView.simRecmdTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.moviePosterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = (indexPath.row) == 0 ? "비슷한 영화" : "추천 영화"
        let images = self.model.moviePosterList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimRecmdTableViewCell.reusableIdentifier, for: indexPath) as? SimRecmdTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(title: title)
        cell.moviePosterCollectionView.delegate = self
        cell.moviePosterCollectionView.dataSource = self
        cell.moviePosterCollectionView.tag = indexPath.row
        return cell
    }
    
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let idx = collectionView.tag
        
        return self.model.moviePosterList[idx].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idx = collectionView.tag
        let poster = self.model.moviePosterList[idx][indexPath.item]
        let posterImage = poster.posterImage
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCollectionViewCell.reusableIdentifier, for: indexPath) as? MoviePosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(imageURL: posterImage)
        return cell
    }
}
