//
//  SignInVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit
import FirebaseAuth

protocol SignInViewDelegate {
    func onSuccessSignIn()
    func onFailure()
}

class SignInVM {
    
    private let delegate: SignInViewDelegate
    
    init(delegate: SignInViewDelegate) {
        self.delegate = delegate
    }
    
    // Sign In Google
    func signInGoogle(parentVC: UIViewController?) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let parentVC = parentVC else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: parentVC) { result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil, let _ = result?.user else { return }
                self.delegate.onSuccessSignIn()
            }
        }
    }
    
    // Sign In Apple
    func signInApple() {
        
    }
    
    // Sign Out
    private func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            self.delegate.onFailure()
        }
    }
}
