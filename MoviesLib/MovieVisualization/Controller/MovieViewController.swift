//
//  ViewController.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 22/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {
    
    //MARK: - Properties
    var movie: Movie!
    
    //MARK: - IBOutlets

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //imageViewPoster.image = UIImage(named: movie.image ?? "placeholder")
        labelTitle.text = movie.title
//        labelCategories.text = movie.categories
        labelDuration.text = movie.duration
        labelRating.text = movie.ratingFormatted
        textViewSummary.text = movie.summary
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieFormViewController {
            vc.movie = movie
        }
    }
    
    //MARK: - Methods
    
    //MARK: - IBActions
}

