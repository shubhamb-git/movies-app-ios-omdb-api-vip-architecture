//
//  MoviePresenter.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import Foundation

protocol MoviePresentationLogic {
    func presentMovieResponse(response: WSResponse<MovieModel.Movie.ViewModel>?, currentPage: Int, error: Error?)
}

class MoviePresenter: MoviePresentationLogic {
 
    weak var viewController: MovieDisplayLogic?
    
    func presentMovieResponse(response: WSResponse<MovieModel.Movie.ViewModel>?, currentPage: Int, error: Error?) {
        viewController?.didReceiveMoviesResponse(response: response, currentPage: currentPage, error: error)
    }
}
