//
//  DetailRemoteDataSource.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/9/24.
//

import Foundation

class DetailRemoteDataSource {
    private let network: NetworkManager = .shared
    
    private func fetchDetail<T: Codable>(endPoint: CineBrowseEndPoint) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            network.request(endPoint: endPoint)
            { (result: T) in
                continuation.resume(returning: result)
            } onFailure: { error in
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func fetchMovies(endPoint: CineBrowseEndPoint, isMovie: Bool = true) async throws -> MovieListVO {
        return try await withCheckedThrowingContinuation { continuation in
            network.request(
                endPoint: endPoint)
            { (result: MovieListResponse) in
                let movies: [MovieVO] = result.results.map { $0.toVO(type: .related, isMovie: isMovie) }
                let data: MovieListVO = .init(listID: 10, type: MovieListType.related.rawValue, movies: movies)
                continuation.resume(returning: data)
            } onFailure: { error in
                continuation.resume(throwing: error)
            }
        }
    }
    
    func getMovieDetail(id: Int) async throws -> DetailResponse {
        return try await fetchDetail(endPoint: .MovieDetail(id))
    }
    
    func getMovieCredit(id: Int) async throws -> CreditResponse {
        return try await fetchDetail(endPoint: .MovieCredit(id))
    }
    
    func getRelatedMovie(id: Int) async throws ->  MovieListVO {
        return try await fetchMovies(endPoint: .MovieRelated(id))
    }
    
    func getTVDetail(id: Int) async throws -> DetailResponse {
        return try await fetchDetail(endPoint: .TVDetail(id))
    }
    
    func getTVCredit(id: Int) async throws -> CreditResponse {
        return try await fetchDetail(endPoint: .TVCredit(id))
    }
    
    func getRelatedTV(id: Int) async throws ->  MovieListVO {
        return try await fetchMovies(endPoint: .TVRelated(id), isMovie: false)
    }
}
