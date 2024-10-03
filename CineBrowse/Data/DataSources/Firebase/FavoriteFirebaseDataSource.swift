//
//  HistoryFirebaseDataSource.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FavoriteFirebaseDataSource {
    static let shared: FavoriteFirebaseDataSource = .init()
    
    private let db: Firestore!
    
    private let collectionName: String = "favorites"
    
    private init() {
        self.db = Firestore.firestore()
    }
    
    func addFavorite(for movie: FavoriteVO) async throws {
        let userId = Auth.auth().currentUser!.uid
        return try await db.collection("users").document(userId).collection(collectionName).document(String(movie.movieID)).setData(movie.toDict())
        
    }
    
    func removeFavorites() async throws {
        let userId = Auth.auth().currentUser!.uid
        return try await db.collection("users").document(userId).delete()
    }
    
    func removeFavoriteById(for movieId: Int) async throws {
        let userId = Auth.auth().currentUser!.uid
        return try await db.collection("users").document(userId).collection(collectionName).document(String(movieId)).delete()
    }
    
    func getFavorites() async throws -> [FavoriteVO] {
        let userId = Auth.auth().currentUser!.uid
        let snapShot = try await db.collection("users").document(userId).collection(collectionName).getDocuments()
        return try snapShot.documents.map { try $0.data(as: FavoriteVO.self) }
    }
    
    func isAlreadyFavorite(for movieId: Int) async throws -> Bool {
        let userId = Auth.auth().currentUser!.uid
        return try await db.collection("users").document(userId).collection(collectionName).document(String(movieId)).getDocument().exists
    }
}
