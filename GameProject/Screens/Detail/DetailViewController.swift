//
//  DetailViewController.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import UIKit

class DetailViewController: UIViewController, DetailViewModelOutput {
    func showDetails(details: DetailModel) {
        viewSource.populate(with: details)
    }
    
    
    func showError(errorMessage: String) {
        print("Error")
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
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.output = self
        viewModel.onViewDidLoad()
        title = "Detail"
        
    }
}
