//
//  movieViewModelConstant.swift
//  izlemeTahmin
//
//  Created by Yusiff on 18.06.2024.
//

import Foundation

protocol outPutDelegateProtocol{
    func output(_outPut:endpointOutput)
}


enum endpointOutput{
    case popular ([ResultFilm])
    case topRated ([ResultFilm])
    case upComing ([ResultFilm])
    case discover ([ResultFilm])
    case trendingDay ([ResultFilm])
    case trendingWeek ([ResultFilm])
    case trendingPerson ([KnownFor])
    case trendingAllDay ([ResultFilm])
}
