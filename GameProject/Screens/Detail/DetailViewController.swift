//
//  DetailViewController.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import UIKit

class DetailViewController: UIViewController, DetailViewModelOutput {
    
    func addNoteTapped(details: DetailModel) {
        present(NoteViewController(with: NoteViewModel(detailModel: details)), animated: false)
    }
    
    func showDetails(details: DetailModel) {
        viewSource.populate(with: details)
    }
    
    
    func showError(errorMessage: String) {
        print("Error")
        showAlert(withTitle: "whoops".localized(), withMessage: "something_went_wrong".localized())
    }
    
    func isLoading(_ value: Bool) {
        DispatchQueue.main.async {
            if value == true {
                self.viewSource.activityIndicator.startAnimating()
            } else {
                self.viewSource.activityIndicator.stopAnimating()
            }
        }

    }
    
    private lazy var viewSource = DetailView()
    let viewModel: DetailViewModel
    
    init(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewSource
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.output = self
        title = "detail".localized()
        viewSource.noteButton.addTarget(nil, action: #selector(noteButtonTapped), for: .touchUpInside)
        viewSource.favoriteButton.addTarget(nil, action: #selector(favButtonTapped), for: .touchUpInside)
    }
    @objc func noteButtonTapped() {
        viewModel.addNoteTapped()
    }
    @objc func favButtonTapped() {
        viewModel.addFavTapped()
    }
}
