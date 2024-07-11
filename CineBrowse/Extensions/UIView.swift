//
//  UIButton.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(
        opacity: Float = 0.4,
        offset: CGSize = CGSize(width: 0, height: 0),
        color: UIColor = UIColor.systemGray,
        radius: CGFloat = 5
    )
    {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
    }
    
    func addBorder(
        width: CGFloat = 1,
        color: UIColor = UIColor.label,
        cornerRadius: CGFloat = 5
    )
    {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
