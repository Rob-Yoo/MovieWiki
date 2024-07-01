//
//  MovieDetailRootView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 7/1/24.
//

import UIKit
import SnapKit
import Then

final class MovieDetailRootView: UIView {
    
    let movieTrailerView = MovieTrailerView().then {
        $0.backgroundColor = .clear
    }
    
    let simRecmdTableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .white
        $0.rowHeight = 200
        $0.register(SimRecmdTableViewCell.self, forCellReuseIdentifier: SimRecmdTableViewCell.reusableIdentifier)
        $0.separatorStyle = .none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(movieTrailerView)
        self.addSubview(simRecmdTableView)
    }
    
    private func configureLayout() {
        movieTrailerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        simRecmdTableView.snp.makeConstraints {
            $0.top.equalTo(movieTrailerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
