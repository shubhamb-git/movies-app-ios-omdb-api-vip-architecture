//
//  MovieWorker.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

class MovieWorker {

    static func getMoviesList(pageIndex: Int, completionHandler: @escaping (WSResponse<MovieModel.Movie.ViewModel>?, Int, Error?) -> Void) {
        
        NetworkService.dataRequest(with: pageIndex) { (response, error) in
            completionHandler(response,pageIndex, error)
        }
    }
}

