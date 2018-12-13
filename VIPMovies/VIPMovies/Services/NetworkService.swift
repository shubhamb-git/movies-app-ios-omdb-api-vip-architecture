//
//  NetworkService.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    static func dataRequest(with pageIndex: Int, completionHandler: @escaping (WSResponse<MovieModel.Movie.ViewModel>?, Error?) -> Void)
}

class NetworkService: NetworkProtocol {
    
    static func dataRequest(with pageIndex: Int, completionHandler: @escaping (WSResponse<MovieModel.Movie.ViewModel>?, Error?) -> Void) {
        let serviceUrl = URL(string: "http://www.omdbapi.com/?s=Bat&page=\(pageIndex)&apikey=eeefc96f")
        
        var request = URLRequest(url: serviceUrl!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(WSResponse<MovieModel.Movie.ViewModel>.self, from: data)
                    completionHandler(decodedValue, nil)
                }catch {
                    print(error)
                    completionHandler(nil, error)
                }
            }
            }.resume()
        
    }
}
