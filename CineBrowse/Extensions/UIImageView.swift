//
//  UIImageView.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/8/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(path: String, indicatorType: IndicatorType = .activity, animateDuration: TimeInterval = 1) {
        let environment = ProcessInfo.processInfo.environment
        let baseURL = URL(string: environment["IMG_URL"] ?? "")
        guard let baseURL = baseURL else { return }
        let url = baseURL.appending(path: path)
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 10)
        self.kf.indicatorType = indicatorType
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "no_poster"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(animateDuration)),
                .cacheOriginalImage
            ]
        )
    }
    
    func setImage(url: URL?, indicatorType: IndicatorType = .activity, animateDuration: TimeInterval = 1) {
        guard let url = url else { return }
        let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 10)
        self.kf.indicatorType = indicatorType
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "no_poster"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(animateDuration)),
                .cacheOriginalImage
            ]
        )
    }
}
