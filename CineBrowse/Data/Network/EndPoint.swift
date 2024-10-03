//
//  EndPoint.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation
import Alamofire

protocol EndPoint: URLConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var parameter: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension EndPoint {
    var baseURL: URL {
        let environment = ProcessInfo.processInfo.environment
        return URL(string: environment["BASE_URL"] ?? "")!
    }
    
    func asURL() throws -> URL {
        return baseURL.appending(path: path)
    }
}
