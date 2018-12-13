//
//  UIImageView+Extension.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//


import UIKit
import SDWebImage

extension UIImageView {
    
    static var placeHolderImage: UIImage? = UIImage(named: "placeholder")
    
    func setImage(with url: String?, placeHolder: UIImage? = nil, completed: (() -> Void)? = nil) {
        if let urlString = url {
            self.sd_setImage(with: URL(string: urlString), placeholderImage: placeHolder) { (_, _, _, _) in
                completed?()
            }
        } else {
            self.image = placeHolder
        }
    }
}

