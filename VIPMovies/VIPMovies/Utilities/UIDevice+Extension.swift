//
//  UIDevice+Extension.swift
//  VIPMovies
//
//  Created by Shubham on 13/12/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

extension UIDevice {
    static func isDeviceIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

