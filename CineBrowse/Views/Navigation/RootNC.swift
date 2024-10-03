//
//  RootNC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit
import FirebaseAuth

class RootNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLoginStatus()
    }
    
    private func checkLoginStatus() {
        if Auth.auth().currentUser != nil {
            goToHome()
        }
        else {
            if UserDefaults.getUser() {
                goToSignIn()
            }
        }
    }

    private func goToSignIn() {
        let vc = SignInVC.instantiate()
        self.setViewControllers([vc], animated: true)
    }
    
    private func goToHome() {
        let vc = TabBarVC()
        self.setViewControllers([vc], animated: true)
    }
}
