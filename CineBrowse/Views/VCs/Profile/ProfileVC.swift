//
//  ProfileVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class ProfileVC: UIViewController, Storyboarded {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail:  UILabel!
    @IBOutlet weak var lblFavorite: UILabel!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnTermCondition: UIButton!
    @IBOutlet weak var btnContactUs: UIButton!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    
    static var storyboardName: String = "Home"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tabBarItem = UITabBarItem.init(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 4
        )
    }
    
    private lazy var vm: ProfileVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.getUserInfo()
    }
    
    private func setUpViews() {
        self.imgUser.addShadow(color: .white, radius: 7)
    }
    
    private func setUpBindings() {
        btnLogOut.addTarget(self, action: #selector(onTapLogOut), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(onTapDelete), for: .touchUpInside)
        btnPrivacyPolicy.addTarget(self, action: #selector(onTapPrivacyPolicy), for: .touchUpInside)
        btnTermCondition.addTarget(self, action: #selector(onTapTermsCondition), for: .touchUpInside)
    }
    
    @objc func onTapLogOut() {
        self.showConfirmAlert(title: "Logout", message: "Are you sure to log out?") { _ in
            self.vm.logout()
        }
    }
    
    @objc func onTapDelete() {
        self.showConfirmAlert(title: "Delete Account", message: "Are you sure to delete this account?") { _ in
            self.vm.deleteAcc()
        }
    }
    
    @objc func onTapPrivacyPolicy() {
        let vc = PrivacyPolicyVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onTapTermsCondition() {
        let vc = TermConditionVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileVC: ProfileViewDelegate {
    func onLoadUser() {
        DispatchQueue.main.async {
            self.lblName.text = self.vm.user?.displayName
            self.lblEmail.text = self.vm.user?.email
            self.imgUser.setImage(url: self.vm.user?.photoURL)
            self.lblVersion.text = "v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)"
            self.lblFavorite.text = String(self.vm.favoriteCount)
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showOkAlert(title: "Error", message: "Something went wrong")
        }
    }
    
    func onSuccessDeleteOrLogout() {
        let vc = SignInVC.instantiate()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
