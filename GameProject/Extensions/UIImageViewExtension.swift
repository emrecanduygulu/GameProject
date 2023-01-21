//
//  UIImageViewExtension.swift
//  GameProject
//
//  Created by emre can duygulu on 18.01.2023.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
       
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self.image = loadedImage
                }
            }
        }
    }

