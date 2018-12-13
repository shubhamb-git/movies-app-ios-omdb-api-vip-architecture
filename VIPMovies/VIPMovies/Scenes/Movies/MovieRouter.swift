//
//  MovieListRouter.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//
import UIKit
import Foundation

protocol MovieRoutingLogic {
    func showDetails(`for` movie: MovieModel.Movie.ViewModel)
}

class MovieRouter: NSObject, MovieRoutingLogic {
    weak var viewController: MoviesListVC?

    func showDetails(`for` movie: MovieModel.Movie.ViewModel) {
        // redirct to movie detail screen
        guard let viewController = viewController else {
            return
        }
        viewController.performSegue(withIdentifier: viewController.detailsSegueId, sender: movie)
    }
}
