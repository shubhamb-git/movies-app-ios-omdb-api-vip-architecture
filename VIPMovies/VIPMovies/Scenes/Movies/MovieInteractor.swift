//
//  MovieInteractor.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

protocol MovieBusinessLogic {
    func getMovies(for pageIdex: Int)
}

class MovieInteractor: MovieBusinessLogic {
    
    var presenter: MoviePresentationLogic?
    
    func getMovies(for pageIdex: Int) {
        MovieWorker.getMoviesList(pageIndex: pageIdex) { [weak self] (response, currentPage, error) in
            self?.presenter?.presentMovieResponse(response: response, currentPage: currentPage, error: error)
        }
    }
}
