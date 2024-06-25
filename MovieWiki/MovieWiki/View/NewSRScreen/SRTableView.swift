//
//  SRTableView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit

final class SRTableView: UITableView {
    
    var moviePosterList = [[MoviePosterEntity]]() {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.backgroundColor = .white
        self.rowHeight = 200
        self.delegate = self
        self.dataSource = self
        self.register(SRTableViewCell.self, forCellReuseIdentifier: SRTableViewCell.reusableIdentifier)
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePosterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = (indexPath.row) == 0 ? "비슷한 영화" : "추천 영화"
        let images = self.moviePosterList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SRTableViewCell.reusableIdentifier, for: indexPath) as? SRTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(title: title, posterImageList: images)
        return cell
    }
    
    
}
