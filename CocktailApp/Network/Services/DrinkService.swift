//
//  DrinkService.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import Foundation

protocol DrinkServiceProtocol {
    func getAllDrinks(category: String, completion: @escaping (Result<AllDrinkResponse, NetworkError>) -> Void)
    func getDrink(id: String, completion: @escaping (Result<AllDrinkResponse, NetworkError>) -> Void)
}

struct DrinkService: DrinkServiceProtocol {
    
    private let network = Network()
    
    func getAllDrinks(category: String, completion: @escaping (Result<AllDrinkResponse, NetworkError>) -> Void) {
        if (category == "Alcoholic") || (category == "Non_Alcoholic") {
            let urlRequest = URLRequest(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=\(category)")!)
            network.performRequest(request: urlRequest, completion: completion)
        } else {
            let urlRequest = URLRequest(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(category)")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
        
    }
    
    func getDrink(id: String, completion: @escaping (Result<AllDrinkResponse, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
    
}

