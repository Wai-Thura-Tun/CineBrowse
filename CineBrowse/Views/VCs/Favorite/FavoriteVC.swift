//
//  FavoriteVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class FavoriteVC: UIViewController, Storyboarded {

    @IBOutlet weak var cvFavorite: UICollectionView!
    @IBOutlet weak var viewEmptyFavorite: UIView!
    
    static var storyboardName: String = "Home"
    
    private lazy var vm: FavoriteVM = .init(delegate: self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tabBarItem = UITabBarItem.init(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            tag: 3
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        createLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vm.getFavorites()
    }
    
    private func setUpViews() {
        cvFavorite.dataSource = self
        cvFavorite.delegate = self
        cvFavorite.register(UINib.init(nibName: "FavoriteCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
    }
    
    private func createLayout() {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.7)),
            repeatingSubitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(15)
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.cvFavorite.setCollectionViewLayout(layout, animated: true)
    }
}

extension FavoriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell
        guard let cell = cell else { return UICollectionViewCell.init() }
        cell.data = self.vm.favorites[indexPath.row]
        return cell
    }
}

extension FavoriteVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.vm.favorites[indexPath.row].toMovieVO()
        let vc = DetailVC.instantiate()
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteVC: FavoriteViewDelegate {
    func onLoadFavorites() {
        DispatchQueue.main.async {
            self.cvFavorite.isHidden = !(self.vm.favorites.count > 0)
            self.viewEmptyFavorite.isHidden = self.vm.favorites.count > 0
            self.cvFavorite.reloadData()
        }
    }
    
    func onError(error: String) {
        func onError(error: String) {
            DispatchQueue.main.async { [weak self] in
                self?.showOkAlert(title: "Error", message: "Something went wrong")
            }
        }
    }
}
