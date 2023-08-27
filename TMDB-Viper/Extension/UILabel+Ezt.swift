//
//  UILabel+Ezt.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import UIKit

extension UILabel {
    func applyStyle(linesCount: Int = 1,
                    size: CGFloat = 14,
                    color: UIColor,
                    isBold: Bool = false) {
        numberOfLines = linesCount
        font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        textColor = color
    }
}
