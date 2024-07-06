//
//  UIViewController.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showOkAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
}
