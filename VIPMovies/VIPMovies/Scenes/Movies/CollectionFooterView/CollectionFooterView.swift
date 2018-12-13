//
//  CollectionFooterView.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

class CollectionFooterView: UICollectionReusableView {
  
    static let nib = UINib.init(nibName: "CollectionFooterView", bundle: nil)
    static let identifier = "CollectionFooterView"
    
    class func registerSupplementaryView(`for` collectionView: UICollectionView) {
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
    }

}
