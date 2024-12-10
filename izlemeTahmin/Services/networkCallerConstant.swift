//
//  networkCallerConstant.swift
//  izlemeTahmin
//
//  Created by Yusiff on 18.06.2024.
//

import Foundation


protocol netwtokCallerConstantProtocol{
    var baseUrl : String{get}
    var genreUrl: String{get}
    var apiKey: String{get}
    var httpMethods: httpMethods{get}
    
    func apiUrl()->String
    func makeRequest()->URLRequest
    
}


enum endPoint{
    case popular
    case topRated
    case upComing
    case discover
    case trendingDay
    case trendingWeek
    case trendPerson
    case trendAllDay
}


enum httpMethods: String{
    case get = "GET"
    case post = "POST"
}


extension endPoint:netwtokCallerConstantProtocol{
    var baseUrl: String {
        switch self {
        case .popular:
            return "https://api.themoviedb.org/3/movie/"
        case .topRated:
            return "https://api.themoviedb.org/3/movie/"
        case .upComing:
            return "https://api.themoviedb.org/3/movie/"
        case .discover:
            return "https://api.themoviedb.org/3/"
        case .trendingDay:
            return "https://api.themoviedb.org/3/"
        case .trendingWeek:
            return "https://api.themoviedb.org/3/"
        case .trendPerson:
            return "https://api.themoviedb.org/3/"
        case .trendAllDay:
            return "https://api.themoviedb.org/3/"
       
        }
    }
    

    var genreUrl: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upComing:
            return "upcoming"
        case .discover:
            return "discover/movie?"
        case .trendingDay:
            return "trending/movie/day"
        case .trendingWeek:
            return "trending/movie/week"
        case .trendPerson:
            return "trending/person/day"
        case .trendAllDay:
            return "trending/all/day"

        }
    }

    var apiKey: String {
            return "?language=tr-TR&api_key=..."

    }
    
    var httpMethods: httpMethods {
        switch self {
        case .popular:
            return .get
        case .topRated:
            return .get
        case .upComing:
            return .get
        case .discover:
            return .get
        case .trendingDay:
            return .get
        case .trendingWeek:
            return .get
        case .trendPerson:
            return .get
        case .trendAllDay:
            return.get
  
            
            
        }
    }
    
  
    
    func apiUrl() -> String {
        return "\(baseUrl)\(genreUrl)\(apiKey)"
    }
    
    func makeRequest() -> URLRequest {
        guard let aUrl = URLComponents(string: apiUrl())else {
            fatalError("Not Url")
        }
        
        guard let url = aUrl.url else {
            fatalError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.rawValue
        return request
    }
    
    
}
