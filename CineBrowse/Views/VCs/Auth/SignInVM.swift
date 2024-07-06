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

protocol SignInViewDelegate {
    func onSuccessSignIn()
    func onFailure()
}

class SignInVM {
    
    private let delegate: SignInViewDelegate
    private let profileRepository: ProfileRepository = .init()
    
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
                guard error == nil, let user = result?.user else { return }
                let profile = ProfileVO.init(
                    uid: user.uid,
                    name: user.displayName ?? "",
                    email: user.email ?? "",
                    photoUrl: user.photoURL?.absoluteString ?? ""
                )
                self.saveProfile(profile: profile)
            }
        }
    }
    
    // Sign In Apple
    func signInApple() {
        
    }
    
    // Save Profile After Success Sign-In
    private func saveProfile(profile: ProfileVO) {
        profileRepository.saveProfile(for: profile) {
            self.delegate.onSuccessSignIn()
        } onFailure: { error in
            self.signOut()
        }

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
