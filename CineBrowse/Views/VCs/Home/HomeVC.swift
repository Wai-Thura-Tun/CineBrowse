//
//  HomeVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {

    static var storyboardName: String = "Home"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tabBarItem = UITabBarItem.init(
            title: "Home",
            image: UIImage(systemName: "house") ,
            tag: 1
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
