//
//  Network.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import Foundation

struct Network {
    
    private let urlSession = URLSession.shared //Singleton usage
    
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                } else if error != nil {
                    completion(.failure(.networkError))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    
    case decodingError
    case networkError
    case unknownError
}
