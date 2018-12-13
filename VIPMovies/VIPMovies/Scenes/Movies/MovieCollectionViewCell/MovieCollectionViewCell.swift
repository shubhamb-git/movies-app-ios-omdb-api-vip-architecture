//
//  MovieCollectionViewCell.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let nib = UINib.init(nibName: "MovieCollectionViewCell", bundle: nil)
    static let cellId = "MovieCollectionViewCell"
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    class func registerCell(`for` collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
        
    static func cell(for collectionView: UICollectionView, at indexPath: IndexPath, with movie: MovieModel.Movie.ViewModel) -> MovieCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MovieCollectionViewCell else {
            return MovieCollectionViewCell()
        }
        cell.lblName.text = movie.title
        cell.lblType.text = movie.type
        cell.lblTime.text = movie.getYearSinceDate()
        
        cell.loader.startAnimating()
        cell.imagePoster.setImage(with: movie.poster, placeHolder: UIImageView.placeHolderImage) {
            cell.loader.stopAnimating()
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContainer.layer.borderWidth = 1
        self.viewContainer.layer.cornerRadius = 5
        self.viewContainer.layer.borderColor = UIColor.clear.cgColor
        self.viewContainer.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}
