//
//  MovieModel.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

enum MovieModel {
    
    enum Movie {
        class ViewModel: Codable {
            var title: String?
            var year: String?
            var imdbID: String?
            var type: String?
            var poster: String?
            
            private var formattedTimeString: String?
            
            func getYearSinceDate() -> String? {
                if formattedTimeString == nil {
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = Date.dateFormat
                    if let year = year, let date = dateFormat.date(from: year) {
                        formattedTimeString = date.yearAgoSinceDate()
                    }
                }
                return formattedTimeString
            }
            
            private enum CodingKeys: String, CodingKey {
                case title = "Title"
                case year = "Year"
                case imdbID
                case type = "Type"
                case poster = "Poster"
            }
            
            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(title, forKey: .title)
                try container.encode(year, forKey: .year)
                try container.encode(imdbID, forKey: .imdbID)
                try container.encode(type, forKey: .type)
                try container.encode(poster, forKey: .poster)
            }
            
            required public init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                title = try? values.decode(String.self, forKey: .title)
                year = try? values.decode(String.self, forKey: .year)
                imdbID = try? values.decode(String.self, forKey: .imdbID)
                type = try? values.decode(String.self, forKey: .type)
                poster = try? values.decode(String.self, forKey: .poster)
            }
        }
    }
}
