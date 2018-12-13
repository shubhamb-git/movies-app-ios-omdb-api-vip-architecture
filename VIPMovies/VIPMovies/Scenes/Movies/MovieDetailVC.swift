//
//  MovieDetailVC.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

class MovieDetailVC: BaseViewController {
    
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblType: UILabel!

    @IBOutlet weak var loader: UIActivityIndicatorView!

    var movie: MovieModel.Movie.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            loader.startAnimating()
            imagePoster.setImage(with: movie.poster, placeHolder: UIImageView.placeHolderImage) { [ weak self] in
                self?.loader.stopAnimating()
            }
            lblTitle.text = movie.title
            lblType.text = "\(movie.type ?? "Type not available"), \(movie.getYearSinceDate() ?? "Year not available")"
        }
    }
}
