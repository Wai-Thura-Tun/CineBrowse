//
//  NetworkManager.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared: NetworkManager = .init()
    
    private let session: Session
    
    private init() {
        self.session = Session(interceptor: CineBrowseInterceptor())
    }
    
    func request<T: Codable>(
        endPoint: CineBrowseEndPoint,
        onSuccess: @escaping (T) -> (),
        onFailure: @escaping (NetworkError) -> ()
    )
    {
        session.request(
            endPoint,
            method: endPoint.method,
            parameters: endPoint.parameter,
            encoding: endPoint.encoding,
            headers: endPoint.header
        ).response { afResponse in
            if let statusCode = afResponse.response?.statusCode {
                if (200..<300) ~= statusCode {
                    if let data = afResponse.data {
                        let object = try? JSONDecoder().decode(T.self, from: data)
                        if let object = object {
                            onSuccess(object)
                        }
                        else {
                            onFailure(.DECODE_ERROR)
                        }
                    }
                    else {
                        onFailure(.EMPTY_RESPONSE)
                    }
                }
                else {
                    onFailure(.INVALID_STATUS_CODE(statusCode))
                }
            }
            else {
                onFailure(.EMPTY_RESPONSE)
            }
        }
    }
}
