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
    
    private var circleView: UIView = {
       let cView = UIView()
        cView.clipsToBounds = true
        cView.backgroundColor = .darkTeal
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
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
        rating.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(rating)
        addSubview(circleView)
        NSLayoutConstraint.activate([
           HStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
           HStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
           HStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
           HStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
           VStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
           VStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
           gameLabel.trailingAnchor.constraint(equalTo: circleView.leadingAnchor),
           gameImage.heightAnchor.constraint(equalToConstant: 80),
           gameImage.widthAnchor.constraint(equalToConstant: 80),
           circleView.heightAnchor.constraint(equalToConstant: 40),
           circleView.widthAnchor.constraint(equalToConstant: 40),
           circleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
           circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           rating.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
           rating.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
           ratingCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        circleView.layer.cornerRadius = 20
        gameLabel.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameLabel.text = nil
        rating.text = nil
        ratingCount.text = nil
        gameImage.image = nil
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
        rating.text = "\(game.rating ?? 0.0)"
        ratingCount.text = "Rating count: \(game.ratingsCount ?? 0)"
        gameImage.loadFrom(URLAddress: game.backgroundImage ?? "")
        rating.textColor = setTextColor(for: game.rating ?? 0.0)
    }
    func setTextColor(for rating: Double) -> UIColor {
        switch rating {
        case 0.00...2.00:
            return .ratingRed
        case 2.01...3.00:
            return .ratingYellow
        case 3.01...4.00:
            return .ratingDarkGreen
        case 4.01...5.00:
            return .ratingLightGreen
        default:
            return UIColor.black
        }
    }

}
