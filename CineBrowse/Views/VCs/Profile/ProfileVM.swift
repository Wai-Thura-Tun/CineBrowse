//
//  ProfileVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import Foundation
import FirebaseAuth

protocol ProfileViewDelegate {
    func onLoadUser()
    func onError(error: String)
    func onSuccessDeleteOrLogout()
}

class ProfileVM {
    
    private let delegate: ProfileViewDelegate
    
    private let favoriteRepository: FavoriteRepository = .init()
    
    private(set) var favoriteCount: Int = 0
    
    init(delegate: ProfileViewDelegate) {
        self.delegate = delegate
    }
    
    private(set) var user: User? {
        didSet {
            self.delegate.onLoadUser()
        }
    }
    
    func getUserInfo() {
        Task {
            if let user = Auth.auth().currentUser {
                self.user = user
                self.favoriteCount = try await favoriteRepository.getFavorites().count
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.delegate.onSuccessDeleteOrLogout()
        }
        catch {
            self.delegate.onError(error: error.localizedDescription)
        }
    }
    
    func deleteAcc() {
        Auth.auth().currentUser?.delete { error in
            if error == nil {
                self.delegate.onSuccessDeleteOrLogout()
            }
        }
    }
}


