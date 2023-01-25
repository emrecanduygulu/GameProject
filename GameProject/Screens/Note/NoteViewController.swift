//
//  NoteViewController.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//

import UIKit

class NoteViewController: UIViewController, NoteViewModelOutput {
    func showExistingNote(note: String?) {
        viewSource.textField.text = note
            }
    
    private lazy var viewSource = NoteView()
    let viewModel: NoteViewModel
    
    init(with viewModel: NoteViewModel) {
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
        viewSource.saveButton.addTarget(nil, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    @objc func saveButtonTapped() {
        guard let text = viewSource.textField.text else { return }
        viewModel.save(value: text)
        showAlert(withTitle: "success".localized(), withMessage: "saved".localized())
    }
}

