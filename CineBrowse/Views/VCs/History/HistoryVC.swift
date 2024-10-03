//
//  HistoryVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class HistoryVC: UIViewController, Storyboarded {

    static var storyboardName: String = "Home"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tabBarItem = UITabBarItem.init(
            title: "History",
            image: UIImage(systemName: "clock"),
            tag: 4
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
