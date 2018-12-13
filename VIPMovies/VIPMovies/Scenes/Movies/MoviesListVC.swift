//
//  MoviesListVC.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

protocol MovieDisplayLogic: class {
    func didReceiveMoviesResponse(response: WSResponse<MovieModel.Movie.ViewModel>?, currentPage: Int, error: Error?)
}

class MoviesListVC: BaseViewController {
   
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var interactor: MovieInteractor?
   
    var router: (NSObjectProtocol & MovieRoutingLogic)?

    lazy var moviesArray = [MovieModel.Movie.ViewModel]()
    
    var currentPage: Int = 1
    
    var isNextPage: Bool = false
    
    var isNextPageCallInprogress: Bool = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.refreshList(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    var expectedWidth: CGFloat {
        if UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown {
            return ((UIScreen.main.bounds.width - 45) / 2)
        }
        return ((UIScreen.main.bounds.width - 60) / 3)
    }
    
    let detailsSegueId = "showDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        moviesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func initialSetup() {
        // register cell nib
        MovieCollectionViewCell.registerCell(for: moviesCollectionView)
        CollectionFooterView.registerSupplementaryView(for: moviesCollectionView)
        moviesCollectionView.addSubview(refreshControl)
        
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        // data fetch request
        self.interactor?.getMovies(for: currentPage)
    }
    
    // Pull to refresh action
    @objc private func refreshList(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        moviesArray.removeAll()
        moviesCollectionView.reloadData()
        currentPage = 1
        interactor?.getMovies(for: currentPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueId {
            if let destination = segue.destination as? MovieDetailVC, let movie = sender as? MovieModel.Movie.ViewModel {
                destination.movie = movie
            }
        }
    }
}

extension MoviesListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == moviesArray.count {
            return UICollectionViewCell()
        } else {
            return MovieCollectionViewCell.cell(for: collectionView, at: indexPath, with: moviesArray[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: expectedWidth, height: expectedWidth * 1.67)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionElementKindSectionFooter && self.isNextPage && !self.isNextPageCallInprogress {
            print("#NEXT API CALL HERE#")
            isNextPageCallInprogress = true
            interactor?.getMovies(for: self.currentPage + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CollectionFooterView.identifier, for: indexPath)
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isNextPage {
            return CGSize(width: collectionView.bounds.width, height: 44.0)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.showDetails(for: moviesArray[indexPath.item])
    }
}

extension MoviesListVC: MovieDisplayLogic {
    
    func didReceiveMoviesResponse(response: WSResponse<MovieModel.Movie.ViewModel>?, currentPage: Int, error: Error?) {
        if let response = response {
            var startIndex: Int?
            var endIndex: Int?
            if response.success {
                if let movies = response.movies {
                    startIndex = moviesArray.count
                    moviesArray.append(contentsOf: movies)
                    endIndex = moviesArray.count - 1
                }
                isNextPage = moviesArray.count < response.totalMoviesCount
            } else {
                isNextPage = false
            }
            isNextPageCallInprogress = false
            self.currentPage = currentPage
            if let startIndex = startIndex, let endIndex = endIndex {
                DispatchQueue.main.async { [weak self] in
                    let insertIndexPaths = Array(startIndex...endIndex).map { IndexPath(item: $0, section: 0) }
                    self?.moviesCollectionView.insertItems(at: insertIndexPaths)
                }
            }
        } else {
            // show alert for Some thing went wrong
        }
    }
}


