//
//  SeasonEpisodeCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/10/24.
//

import UIKit

protocol SeasonEpisodeCellDelegate: AnyObject {
    func onTapSeason(id: Int)
    func onTapEpisode(id: Int)
}

class SeasonEpisodeCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvSeasonEpisode: UICollectionView!
    
    var isEpisode: Bool = false {
        didSet {
            lblTitle.text = isEpisode ? "Episodes" : "Seasons"
        }
    }
    var selectedIndex: Int = 0
    var itemCount: Int = 0 {
        didSet {
            cvSeasonEpisode.reloadData()
            if itemCount > 0 {
                cvSeasonEpisode.selectItem(at: IndexPath.init(
                    row: selectedIndex,
                    section: 0
                ),
                animated: true,
                scrollPosition: .left)
            }
        }
    }
    
    weak var delegate: SeasonEpisodeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cvSeasonEpisode.register(UINib.init(nibName: "SeasonEpisodeItemCell", bundle: nil), forCellWithReuseIdentifier: "SeasonEpisodeItemCell")
        cvSeasonEpisode.dataSource = self
        cvSeasonEpisode.delegate = self
        createLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createLayout() {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1 / 7),
            heightDimension: .fractionalHeight(1)
        ), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.cvSeasonEpisode.setCollectionViewLayout(layout, animated: true)
    }
}

extension SeasonEpisodeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonEpisodeItemCell", for: indexPath) as? SeasonEpisodeItemCell
        guard let cell = cell else { return UICollectionViewCell.init() }
        cell.data = indexPath.row + 1
        return cell
    }
}

extension SeasonEpisodeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if self.isEpisode {
            self.delegate?.onTapEpisode(id: index)
        }
        else {
            self.delegate?.onTapSeason(id: index)
        }
    }
}
