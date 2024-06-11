//
//  WeeklyMovieTrendTableView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

final class WeeklyMovieTrendTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var movieList: [WeeklyTrendMovie] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movieList[indexPath.row]

        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reusableIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        movieCell.movie = movie
        return movieCell
    }
}
