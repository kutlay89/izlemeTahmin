//
//  viewModel.swift
//  izlemeTahmin
//
//  Created by Yusiff on 19.06.2024.
//

import Foundation

final class movieViewModel{
    var services : networkCaller?
    var delegate: outPutDelegateProtocol?
    
    init(services: networkCaller? = nil) {
        self.services = services

    }
    
    func fetchData(){
        services?.getData(.popular, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let popular):
                self.delegate?.output(_outPut: .popular(popular.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        
        services?.getData(.topRated, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let toprated):
                self.delegate?.output(_outPut: .topRated(toprated.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.upComing, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let upcoming):
                self.delegate?.output(_outPut: .upComing(upcoming.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.discover, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let discover):
                self.delegate?.output(_outPut: .discover(discover.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.trendingDay, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let trendDay):
                self.delegate?.output(_outPut: .trendingDay(trendDay.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.trendingWeek, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let trendWeek):
                self.delegate?.output(_outPut: .trendingWeek(trendWeek.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.trendPerson, completion: { (result: Result<personModel, movieError>) in
            switch result{
            case .success(let trendPerson):
                self.delegate?.output(_outPut: .trendingPerson(trendPerson.results[Int()].knownFor))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        
        services?.getData(.trendAllDay, completion: { (result: Result<movieModel, movieError>) in
            switch result{
            case .success(let trendAllDay):
                self.delegate?.output(_outPut: .trendingAllDay(trendAllDay.results))
            case .failure(.parseError):
                print("PARSE")
            case .failure(.serverError):
                print("services")
            }
        })
        


    }
}
