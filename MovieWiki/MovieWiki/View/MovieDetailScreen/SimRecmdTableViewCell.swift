//
//  SRTableViewCell.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit
import Then

final class SimRecmdTableViewCell: UITableViewCell {

    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy var moviePosterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: MoviePosterCollectionViewCell.reusableIdentifier)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40) / 3.5
        let height = width * 1.4
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(moviePosterCollectionView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        moviePosterCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureCellData(title: String) {
        self.titleLabel.text = title
    }
}
