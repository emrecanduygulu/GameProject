//
//  Detail.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import UIKit

class DetailView: UIView {
    
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var gameImage: UIImageView = {
        let gameImage = UIImageView()
        gameImage.clipsToBounds = true
        gameImage.contentMode = .scaleAspectFill
        gameImage.layer.cornerRadius = 10
        return gameImage
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favButton = UIButton()
        favButton.setTitle("Add to favorites", for: .normal)
        favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favButton.tintColor = .darkTeal
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.tintColor = .lightPink
        favButton.setTitleColor(.darkPink, for: .normal)
        return favButton
    }()
    
    private lazy var noteButton: UIButton = {
        let noteButton = UIButton()
        noteButton.setTitle("Add note", for: .normal)
        noteButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        noteButton.translatesAutoresizingMaskIntoConstraints = false
        noteButton.tintColor = .lightPink
        noteButton.setTitleColor(.darkPink, for: .normal)
        return noteButton
    }()
    
    private var descriptionLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.textAlignment = .left
        dLabel.numberOfLines = 10
        dLabel.font = .systemFont(ofSize: 16)
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        return dLabel
    }()
    
    private lazy var nameLabel = makeLabel(font: .boldSystemFont(ofSize: 26))
    private lazy var metacriticLabel = makeLabel(font: .systemFont(ofSize: 16))
    private lazy var genreLabel = makeLabel(font: .systemFont(ofSize: 16))
    private lazy var noteLabel = makeLabel(font: .boldSystemFont(ofSize: 20))
    
    
    
    private lazy var VStack: UIStackView = {
        let VStackView = UIStackView(arrangedSubviews: [
            gameImage,
            nameLabel,
            HStack,
            descriptionLabel,
            buttonStack,
            noteLabel
        ])
        VStackView.axis = .vertical
        VStackView.spacing = 20
        VStackView.alignment = .fill
        VStackView.distribution = .fill
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        noteLabel.textAlignment = .center
        return VStackView
    }()
    
    private lazy var HStack: UIStackView = {
        let HStackView = UIStackView(arrangedSubviews: [
            metacriticLabel,
            genreLabel
        ])
        HStackView.axis = .horizontal
        HStackView.spacing = 5
        HStackView.alignment = .fill
        HStackView.distribution = .fill
        HStackView.translatesAutoresizingMaskIntoConstraints = false
        return HStackView
    }()
    
    private lazy var buttonStack: UIStackView = {
        let HStackView = UIStackView(arrangedSubviews: [
            favoriteButton,
            UIView(),
            noteButton
        ])
        HStackView.axis = .horizontal
        HStackView.spacing = 5
        HStackView.alignment = .fill
        HStackView.distribution = .fill
        HStackView.translatesAutoresizingMaskIntoConstraints = false
        return HStackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(VStack)
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            VStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            gameImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private func makeLabel(font: UIFont) -> UILabel {
    let label = UILabel()
    label.textColor = .darkTeal
    label.numberOfLines = 1
    label.textAlignment = .left
    label.font = font
    return label
}

extension DetailView {
    func populate(with game: DetailModel) {
        
        nameLabel.text = game.name
        metacriticLabel.text = "Metacritic score: \(game.metacritic ?? 9)"
        genreLabel.text = "Genre: \(game.genres.first?.name ?? "")"
        gameImage.loadFrom(URLAddress: game.backgroundImage ?? "")
        descriptionLabel.text = game.descriptionRaw
        noteLabel.text = "Your Note"
    }
}
