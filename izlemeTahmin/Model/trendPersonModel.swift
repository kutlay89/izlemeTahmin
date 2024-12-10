//
//  trendPersonModel.swift
//  izlemeTahmin
//
//  Created by Yusiff on 19.06.2024.
//

import Foundation
// MARK: - Welcome
struct personModel: Codable {
    let page: Int
    let results: [ResultArtist]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultArtist: Codable {
    let id: Int
    let originalName: String
    let mediaType: ResultMediaType
    let adult: Bool
    let name: String
    let popularity: Double
    let gender: Int
    let knownForDepartment: KnownForDepartment
    let profilePath: String
    let knownFor: [KnownFor]

    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case mediaType = "media_type"
        case adult, name, popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath: String?
    let id: Int
    let originalTitle: String?
    let overview: String
    let posterPath: String?
    let mediaType: KnownForMediaType
    let adult: Bool
    let title: String?
    let originalLanguage: OriginalLanguage
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let originalName, name, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult, title
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum KnownForMediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case it = "it"
    case ko = "ko"
    case zh = "zh"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
    case production = "Production"
}

enum ResultMediaType: String, Codable {
    case person = "person"
}
