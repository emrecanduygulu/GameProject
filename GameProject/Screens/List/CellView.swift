//
//  CellView.swift
//  GameProject
//
//  Created by emre can duygulu on 18.01.2023.
//

import UIKit

class CellView: UITableViewCell {
    
    static let cellId = "CellViewCellId"
    
    private var gameImage: UIImageView = {
            let gameImage = UIImageView()
            gameImage.clipsToBounds = true
            gameImage.contentMode = .scaleAspectFill
            gameImage.layer.cornerRadius = 10
            gameImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            return gameImage
        }()
    lazy var gameLabel = makeLabel(font: .boldSystemFont(ofSize: 18))
    lazy var rating = makeLabel(font: .systemFont(ofSize: 14))
    lazy var ratingCount = makeLabel(font: .systemFont(ofSize: 14))
    
    private lazy var HStack: UIStackView = {
       
        let HStackView = UIStackView(arrangedSubviews: [
        gameImage,
        VStack
        ])
        HStackView.axis = .horizontal
        HStackView.spacing = 5
        HStackView.alignment = .fill
        HStackView.distribution = .fill
        HStackView.translatesAutoresizingMaskIntoConstraints = false
        return HStackView
    }()
    
    private lazy var VStack: UIStackView = {
        let VStackView = UIStackView(arrangedSubviews: [
        gameLabel,
        rating,
        ratingCount
        ])
        VStackView.axis = .vertical
        VStackView.spacing = 5
        VStackView.alignment = .fill
        VStackView.distribution = .fill
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        return VStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        HStack.backgroundColor = .lightPink.withAlphaComponent(0.25)
        HStack.layer.cornerRadius = 10
        addSubview(HStack)
        NSLayoutConstraint.activate([
           HStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
           HStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
           HStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
           HStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
           gameImage.heightAnchor.constraint(equalToConstant: 80),
           gameImage.widthAnchor.constraint(equalToConstant: 80),
        ])
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

extension CellView {
    func populate(with game: Result){
        gameLabel.text = game.name
        rating.text = "\(game.rating)"
        ratingCount.text = "\(game.ratingsCount)"
        gameImage.loadFrom(URLAddress: game.backgroundImage)
        
    }
}
