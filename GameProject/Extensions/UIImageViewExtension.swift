//
//  UIImageViewExtension.swift
//  GameProject
//
//  Created by emre can duygulu on 18.01.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
            }
        self.kf.setImage(with: url)
        }
    }
