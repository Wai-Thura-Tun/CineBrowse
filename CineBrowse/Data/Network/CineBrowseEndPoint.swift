//
//  CineBrowseEndPoint.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation
import Alamofire

enum CineBrowseEndPoint: EndPoint {
    
    case NowPlaying
    case Popular
    case TopRated
    case Upcoming
    case Trending
    case Genre(Encodable)
    case MovieDetail(Int)
    case TVDetail(Int)
    case MovieCredit(Int)
    case TVCredit(Int)
    case MovieRelated(Int)
    case TVRelated(Int)
    case MovieSearch(Encodable)
    case TVSearch(Encodable)
    case MovieGenres
    case TVGenres
    
    var path: String {
        switch self {
        case .NowPlaying:
            "/movie/now_playing"
        case .Popular:
            "/movie/popular"
        case .TopRated:
            "/movie/top_rated"
        case .Upcoming:
            "/movie/upcoming"
        case .Trending:
            "/trending/movie/week"
        case .Genre:
            "/discover/movie"
        case .MovieDetail(let id):
            "/movie/\(id)"
        case .MovieCredit(let id):
            "/movie/\(id)/credits"
        case .MovieRelated(let id):
            "/movie/\(id)/similar"
        case .TVDetail(let id):
            "/tv/\(id)"
        case .TVCredit(let id):
            "tv/\(id)/credits"
        case .TVRelated(let id):
            "/tv/\(id)/similar"
        case .MovieSearch:
            "/search/movie"
        case .TVSearch:
            "/search/tv"
        case .MovieGenres:
            "/genre/movie/list"
        case .TVGenres:
            "/genre/tv/list"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .NowPlaying,
             .Popular,
             .TopRated,
             .Upcoming,
             .Trending,
             .Genre,
             .MovieDetail,
             .TVDetail,
             .MovieCredit,
             .TVCredit,
             .MovieRelated,
             .TVRelated,
             .MovieSearch,
             .TVSearch,
             .MovieGenres,
             .TVGenres:
            .get
        }
    }
    
    var header: Alamofire.HTTPHeaders? {
        switch self {
        case .NowPlaying,
             .Popular,
             .TopRated,
             .Upcoming,
             .Trending,
             .Genre,
             .MovieDetail,
             .TVDetail,
             .MovieCredit,
             .TVCredit,
             .MovieRelated,
             .TVRelated,
             .MovieSearch,
             .TVSearch,
             .MovieGenres,
             .TVGenres:
            nil
        }
    }
    
    var parameter: Alamofire.Parameters? {
        switch self {
        case .NowPlaying,
             .Popular,
             .TopRated,
             .Upcoming,
             .Trending,
             .MovieDetail,
             .TVDetail,
             .MovieCredit,
             .TVCredit,
             .MovieRelated,
             .TVRelated,
             .MovieGenres,
             .TVGenres:
            nil
        case .Genre(let request),
             .MovieSearch(let request),
             .TVSearch(let request):
            request.toDict()
        }
    }
    
    var encoding: any Alamofire.ParameterEncoding {
        switch self {
        case .NowPlaying,
             .Popular,
             .TopRated,
             .Upcoming,
             .Trending,
             .Genre,
             .MovieDetail,
             .TVDetail,
             .MovieCredit,
             .TVCredit,
             .MovieRelated,
             .TVRelated,
             .MovieSearch,
             .TVSearch,
             .MovieGenres,
             .TVGenres:
            URLEncoding.default
        }
    }
    
}

extension Encodable {
    func toDict() -> [String: Any] {
        do {
            let encodedData = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: encodedData, options: .fragmentsAllowed) as? [String : Any]
            return dict ?? [:]
        }
        catch {
            return [:]
        }
    }
}
