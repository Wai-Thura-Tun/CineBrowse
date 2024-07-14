//
//  TabBarVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class TabBarVC: UITabBarController {
    
    private var homeVC: HomeVC {
        return HomeVC.instantiate()
    }
    
    private var favoriteVC: FavoriteVC {
        return FavoriteVC.instantiate()
    }
    
    private var profileVC: ProfileVC {
        return ProfileVC.instantiate()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = 
        [
            homeVC,
            favoriteVC,
            profileVC
        ]
        
        tabBar.shadowImage = .init()
        tabBar.addShadow()
        tabBar.backgroundColor = UIColor.black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
    }
    
}
