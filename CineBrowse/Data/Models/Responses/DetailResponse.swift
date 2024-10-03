import Foundation

// MARK: - DetailResponse
struct DetailResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongCollection?
    let budget: Int?
    let createdBy: [Creator]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: EpisodeToAir?
    let name: String?
    let nextEpisodeToAir: EpisodeToAir?
    let networks: [Network]?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let type: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult, genres, homepage, id, languages, name, networks, overview, popularity, seasons, status, tagline, type, budget, revenue, runtime, title, video
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case imdbId = "imdb_id"
        case inProduction = "in_production"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case nextEpisodeToAir = "next_episode_to_air"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongCollection
struct BelongCollection: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Creator
struct Creator: Codable {
    let id: Int?
    let creditID: String?
    let name: String?
    let originalName: String?
    let gender: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, gender
        case creditID = "credit_id"
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// MARK: - EpisodeToAir
struct EpisodeToAir: Codable {
    let id: Int?
    let name: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let airDate: String?
    let episodeNumber: Int?
    let episodeType: String?
    let productionCode: String?
    let runtime: Int?
    let seasonNumber: Int?
    let showID: Int?
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso31661: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int?
    let name: String?
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String?
    let iso6391: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
    }
}

