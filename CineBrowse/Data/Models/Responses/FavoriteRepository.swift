//
//  FavoriteRepository.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation

class FavoriteRepository {
    private let firebaseDataSource: FavoriteFirebaseDataSource = .shared
    
    func addFavorite(for movie: FavoriteVO) async throws {
        return try await firebaseDataSource.addFavorite(for: movie)
    }
    
    func removeFavorites() async throws {
        return try await firebaseDataSource.removeFavorites()
    }
    
    func removeFavoriteById(for movieId: Int) async throws {
        return try await firebaseDataSource.removeFavoriteById(for: movieId)
    }
    
    func getFavorites() async throws -> [FavoriteVO] {
        return try await firebaseDataSource.getFavorites()
    }
    
    func isAlreadyFavorite(for movieId: Int) async throws -> Bool {
        return try await firebaseDataSource.isAlreadyFavorite(for: movieId)
    }
}
