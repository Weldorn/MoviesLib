//
//  Movie+RatingFormatted.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 24/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import Foundation

extension Movie {
    var ratingFormatted: String {
        "⭐️ \(rating ?? 0)/10"
    }
}
