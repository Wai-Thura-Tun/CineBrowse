//
//  PrivacyPolicyVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/13/24.
//

import UIKit

class PrivacyPolicyVC: UIViewController, Storyboarded {

    @IBOutlet weak var btnBack: UIButton!
    
    static var storyboardName: String = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBindings()
    }
    
    private func setUpBindings() {
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }

    @objc func onTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
