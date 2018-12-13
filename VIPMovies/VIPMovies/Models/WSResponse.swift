//
//  Movie.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

public class WSResponse<T: Codable>: Codable {
    
    var movies: [T]?
    private var totalResults: String?
    private var response: String?

    var totalMoviesCount: UInt {
        if let resultC = totalResults {
            return UInt(resultC) ?? 0
        }
        return 0
    }
    
    var success: Bool {
        if response?.lowercased() == "true" {
            return true
        }
        return false
    }
    
    private enum CodingKeys: String, CodingKey {
        case result = "Search"
        case totalResults
        case response = "Response"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movies, forKey: .result)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(success, forKey: .response)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try? values.decode([T].self, forKey: .result)
        totalResults = try? values.decode(String.self, forKey: .totalResults)
        response = try? values.decode(String.self, forKey: .response)
    }
}

