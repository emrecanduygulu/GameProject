//
//  String.swift
//  GameProject
//
//  Created by emre can duygulu on 25.01.2023.
//
import Foundation
import UIKit

extension String {
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
