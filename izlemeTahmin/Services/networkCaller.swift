//
//  networkCaller.swift
//  izlemeTahmin
//
//  Created by Yusiff on 18.06.2024.
//

import Foundation

enum movieError: Error{
    case serverError
    case parseError
}

protocol networkCallerProtocol{
    func getData<T:Decodable>(_ endPoint:endPoint, completion:@escaping (Result<T,movieError>)->Void)
}


final class networkCaller:networkCallerProtocol{
    
    func getData<T:Decodable>(_ endPoint:endPoint, completion:@escaping (Result<T,movieError>)->Void){
        
        URLSession.shared.dataTask(with: endPoint.makeRequest()) { Data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
                print("server error")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                fatalError("not response")
            }
            guard let data = Data else {
                fatalError("not data")
            }
            
            let jsonResponse = try? JSONDecoder().decode(T.self, from: data)
            if let jsonResponse = jsonResponse{
                completion(.success(jsonResponse))
            }
        }
        .resume()
    }
}
