//
//  SplashVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class SplashVC: UIViewController, Storyboarded {

    @IBOutlet weak var btnGetStarted: UIButton!
    
    static var storyboardName: String = "Main"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        btnGetStarted.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
    }

    @objc func goToSignIn() {
        let vc = SignInVC.instantiate()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
