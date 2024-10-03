//
//  SignInVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInVC: UIViewController, Storyboarded {

    @IBOutlet weak var btnGoogleSignIn: UIButton!
    @IBOutlet weak var btnAppleSignIn: UIButton!
    
    static var storyboardName: String = "Auth"
    
    private lazy var vm: SignInVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBindings()
    }

    private func setUpBindings() {
        btnGoogleSignIn.addTarget(self, action: #selector(onTapGoogleSignIn), for: .touchUpInside)
        btnAppleSignIn.addTarget(self, action: #selector(onTapAppleSignIn), for: .touchUpInside)
    }
    
    @objc func onTapGoogleSignIn() {
        self.vm.signInGoogle(parentVC: self)
    }
    
    @objc func onTapAppleSignIn() {
        self.showOkAlert(
            title: "Not Avaliable",
            message: "Apple Sign-in is currently unavaliable."
        )
    }
}

extension SignInVC: SignInViewDelegate {
    func onSuccessSignIn() {
        let vc = TabBarVC.init()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func onFailure() {
        DispatchQueue.main.async { [weak self] in
            self?.showOkAlert(title: "Error", message: "Something went wrong")
        }
    }
}
