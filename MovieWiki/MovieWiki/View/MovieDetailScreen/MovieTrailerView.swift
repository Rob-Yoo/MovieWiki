//
//  MovieTrailerView.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 7/1/24.
//

import UIKit
import SnapKit
import Then
import WebKit

final class MovieTrailerView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "예고편"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(webView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
