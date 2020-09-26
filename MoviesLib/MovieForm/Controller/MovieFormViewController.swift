//
//  MovieFormViewController.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 26/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit

final class MovieFormViewController: UIViewController {
    
    //MARK: - Properties
    var movie: Movie?
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldRating: UITextField!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var textFieldDuration: UITextField!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Methods
    private func setupView() {
        if let movie = movie {
            title = "Edição de filme"
            textFieldTitle.text = movie.title
            textFieldRating.text = "\(movie.rating)"
            textFieldDuration.text = movie.duration
            textViewSummary.text = movie.summary
            buttonSave.setTitle("Alterar", for: .normal)
            if let data = movie.image {
                imageViewPoster.image = UIImage(data: data)
            }
        }
    }
    
    @objc
    private func keyBoardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    @objc
    private func keyBoardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    //MARK: - IBActions
    @IBAction func selectImage(_ sender: UIButton) {
    }
    
    @IBAction func save(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie?.title = textFieldTitle.text
        movie?.summary = textViewSummary.text
        movie?.duration = textFieldDuration.text
        let rating = Double(textFieldRating.text!) ?? 0
        movie?.rating = rating
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.85)
        
        view.endEditing(true)
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
}
