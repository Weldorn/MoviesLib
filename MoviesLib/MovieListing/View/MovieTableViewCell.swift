//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 24/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    //MARK: - Methods
    
    func configureWithMovie (_ movie: Movie) {
        if let image = movie.image {
            imageViewPoster?.image = UIImage(named: "\(image)small")
        }
        labelTitle.text = movie.title
        labelRating.text = movie.ratingFormatted
        labelSummary.text = movie.summary
    }

}
