//
//  Storyboarded.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import UIKit

protocol Storyboarded {
    static var storyboardName: String { get set }
    static func instantiate(bundle: Bundle) -> Self
}

extension Storyboarded {
    static func instantiate(bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(identifier: String(describing: Self.self)) as! Self
    }
}
