//
//  TabBarController.swift
//  MovieWiki
//
//  Created by Jinyoung Yoo on 6/11/24.
//

import UIKit
import Then

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTabBarController()
    }
    
    private func configureTabBarController() {
        self.viewControllers = Tab.allCases.map {
            let (title, image, selectedImage) = $0.itemResource

            return UINavigationController(rootViewController: $0.viewController).then {
                $0.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
            }
        }
        
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .systemGray2
    }
}

extension TabBarController {
    enum Tab: CaseIterable {
        case weeklyTrendMovie
        case searchMovie
        
        var viewController: UIViewController {
            switch self {
            case .weeklyTrendMovie:
                return WeeklyMovieTrendViewController()
            case .searchMovie:
                return SearchMovieViewController()
            }
        }
        
        var itemResource: (title: String, image: UIImage?, selectedImage: UIImage?) {
            switch self {
            case .weeklyTrendMovie:
                return (title: "핫 무비", image: UIImage(systemName: "flame"), selectedImage: UIImage(systemName: "flame.fill"))
            case .searchMovie:
                return (title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
            }
        }
    }
}
