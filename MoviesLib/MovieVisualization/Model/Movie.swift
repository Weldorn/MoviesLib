//
//  Movie.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 24/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String?
    let categories: String?
    let duration: String?
    let rating: Double?
    let summary: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title, categories, duration, rating, summary, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        categories = try container.decodeIfPresent(String.self, forKey: .categories)
        duration = try container.decodeIfPresent(String.self, forKey: .duration)
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)
        image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
}
