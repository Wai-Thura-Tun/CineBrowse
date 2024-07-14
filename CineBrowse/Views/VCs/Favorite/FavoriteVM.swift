//
//  FavoriteVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation

protocol FavoriteViewDelegate {
    func onLoadFavorites()
    func onError(error: String)
}

class FavoriteVM {
    
    private let delegate: FavoriteViewDelegate
    
    init(delegate: FavoriteViewDelegate) {
        self.delegate = delegate
    }
    
    private let repository: FavoriteRepository = .init()
    
    private(set) var favorites: [FavoriteVO] = [] {
        didSet {
            self.delegate.onLoadFavorites()
        }
    }
    
    func getFavorites() {
        Task {
            do {
                self.favorites = try await self.repository.getFavorites()
            }
            catch {
                self.delegate.onError(error: error.localizedDescription)
            }
        }
    }
}
