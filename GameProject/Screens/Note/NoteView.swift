//
//  NoteView.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//

import UIKit

class NoteView: UIView {
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        saveButton.tintColor = .darkTeal
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.tintColor = .lightPink
        saveButton.setTitleColor(.darkPink, for: .normal)
        return saveButton
    }()
    
     lazy var textField: UITextField = {
        let tField = UITextField()
        tField.placeholder = "Enter your note..."
        tField.keyboardType = .default
        tField.returnKeyType = .done
        tField.font = .systemFont(ofSize: 18)
        tField.borderStyle = .roundedRect
        tField.translatesAutoresizingMaskIntoConstraints = false
        
        return tField
    }()
    
    private lazy var VStack: UIStackView = {
       let VStackView = UIStackView(arrangedSubviews: [
       saveButton,
       textField
       ])
        VStackView.axis = .vertical
        VStackView.spacing = 5
        VStackView.alignment = .fill
        VStackView.distribution = .fill
        VStackView.translatesAutoresizingMaskIntoConstraints = false

        return VStackView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(VStack)
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: self.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            VStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

