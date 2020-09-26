//
//  Movie+RatingFormatted.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 24/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit

extension Movie {
    var ratingFormatted: String {
        "⭐️ \(rating ?? 0)/10"
    }
    
    var poster: UIImage? {
        if let data = self.image {
            return UIImage(data: data)
        }
        return nil
    }
}
