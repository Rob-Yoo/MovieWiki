//
//  WeeklyMovieTrendRootView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

final class WeeklyMovieTrendRootView: UIView {
    
    let weeklyMovieTrendTableView = WeeklyMovieTrendTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureWeeklyMovieTrendTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWeeklyMovieTrendTableView() {
        self.addSubview(weeklyMovieTrendTableView)
        
        weeklyMovieTrendTableView.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
}

extension WeeklyMovieTrendRootView {
    func update(movieData: WeeklyTrendingMovieEntity) {
        self.weeklyMovieTrendTableView.movieList = movieData.results
    }
}
