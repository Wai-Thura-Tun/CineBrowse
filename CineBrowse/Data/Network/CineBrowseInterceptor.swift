//
//  CineBrowseInterceptor.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation
import Alamofire

class CineBrowseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNzk2NzE0OTIyODkzMjIzNWU0NTcyZjQzYzdkZTgwNyIsIm5iZiI6MTcyMDA5NDE4OS4wMzQwMTcsInN1YiI6IjY2ODY4YzE1MTRlOTdhNDQyOTQyYTBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ug512TklddXH4J_YNno5ovVD7EIaeTdoepEqqtJ40YQ"))
        completion(.success(request))
    }
}
