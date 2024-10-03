//
//  DetailRepository.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/9/24.
//

import Foundation

class DetailRepository {
    private let remoteDataSource: DetailRemoteDataSource = .init()
    
    func getMovieDetail(id: Int) async throws -> DetailVO {
        async let detail = remoteDataSource.getMovieDetail(id: id)
        async let credit = remoteDataSource.getMovieCredit(id: id)
        async let related = remoteDataSource.getRelatedMovie(id: id)
        
        return try await .init(
            detail: detail,
            credit: credit,
            related: related
        )
    }
    
    func getTVDetail(id: Int) async throws -> DetailVO {
        async let detail = remoteDataSource.getTVDetail(id: id)
        async let credit = remoteDataSource.getTVCredit(id: id)
        async let related = remoteDataSource.getRelatedTV(id: id)
        
        return try await .init(
            detail: detail,
            credit: credit,
            related: related
        )
    }
}
