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
    var selectedCategories: Set<Category> = [] {
        didSet {
            if selectedCategories.count > 0 {
                labelCategories.text = selectedCategories.compactMap({$0.name}).sorted().joined(separator: " | ")
            } else {
                labelCategories.text = "Categorias"
            }
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoriesViewController = segue.destination as? CategoriesTableViewController {
            categoriesViewController.selectedCategories = selectedCategories
            categoriesViewController.delegate = self
        }
    }
    
    //MARK: - Methods
    
    private func selectPictureFrom(_ sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func setupView() {
        if let movie = movie {
            title = "Edição de filme"
            textFieldTitle.text = movie.title
            textFieldRating.text = "\(movie.rating)"
            textFieldDuration.text = movie.duration
            textViewSummary.text = movie.summary
            buttonSave.setTitle("Alterar", for: .normal)
            imageViewPoster.image = movie.poster
            if let categories = movie.categories as? Set<Category>, categories.count > 0 {
                selectedCategories = categories
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
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você deseja escolher o pôster", preferredStyle: .alert)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                self.selectPictureFrom(.camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (_) in
            self.selectPictureFrom(.photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default) { (_) in
            self.selectPictureFrom(.savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
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
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.9)
        movie?.categories = selectedCategories as NSSet?
        
        view.endEditing(true)
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
}

extension MovieFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension MovieFormViewController: CategoriesDelegate {
    func setSelectedCategories(_ categories: Set<Category>) {
        selectedCategories = categories
    }
}
