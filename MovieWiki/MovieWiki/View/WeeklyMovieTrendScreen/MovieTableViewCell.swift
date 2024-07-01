//
//  MovieTableViewCell.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import SnapKit
import Then

final class MovieTableViewCell: UITableViewCell {
    
    var movie: WeeklyTrendMovie? {
        didSet {
            self.configureHierarchy()
            self.configureLayout()
        }
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private lazy var genreHashTagLabelStackView = GenreHashTagLabelStackView(genres: GenreManger.shared.convertIdIntoName(genreIDs: self.movie?.genres ?? []))
    
    private lazy var movieCardView = MovieCardView(movie: self.movie!)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(genreHashTagLabelStackView)
        self.contentView.addSubview(movieCardView)
    }
    
    private func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            dateLabel.text = self.movie?.releaseDate.formatDate(inputDateFormat: "yyyy-MM-dd", outputDateFormat: "yyyy/MM/dd")
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        genreHashTagLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalTo(dateLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        
        movieCardView.snp.makeConstraints { make in
            make.top.equalTo(genreHashTagLabelStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}
