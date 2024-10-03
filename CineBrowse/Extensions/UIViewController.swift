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
    
    func showConfirmAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertVC = UIAlertController.init(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: handler)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel)
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
}
