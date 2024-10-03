//
//  CastCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/10/24.
//

import UIKit

class CastCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvCast: UICollectionView!
    
    var data: [CastVO]? = [] {
        didSet {
            lblTitle.text = "Casts"
            cvCast.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpViews()
        createLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpViews() {
        cvCast.dataSource = self
        cvCast.delegate = self
        cvCast.register(UINib.init(nibName: "CastItemCell", bundle: nil), forCellWithReuseIdentifier: "CastItemCell")
    }
    
    private func createLayout() {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.28),
                heightDimension: .fractionalHeight(1)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.cvCast.setCollectionViewLayout(layout, animated: true)
    }
}

extension CastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastItemCell", for: indexPath) as? CastItemCell
        guard let cell = cell else { return UICollectionViewCell.init() }
        cell.data = data?[indexPath.row]
        return cell
    }
}

extension CastCell: UICollectionViewDelegate {
    
}
