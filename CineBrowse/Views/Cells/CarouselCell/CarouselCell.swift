//
//  CarouselCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import UIKit

protocol CarouselCellDelegate: AnyObject {
    func onClickCarouselItem(movie: MovieVO)
}

class CarouselCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvCarousel: UICollectionView!
    
    var data: MovieListVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.type
                updateSnapShot()
            }
        }
    }
    
    weak var delegate: CarouselCellDelegate?
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, MovieVO>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpViews()
        createLayout()
        setUpDataSource()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cvCarousel.setContentOffset(.zero, animated: false)
    }
    
    private func setUpViews() {
        cvCarousel.delegate = self
        cvCarousel.register(UINib.init(nibName: "CarouselItemCell", bundle: nil), forCellWithReuseIdentifier: "CarouselItemCell")
    }
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.cvCarousel) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselItemCell", for: indexPath) as?  CarouselItemCell
            guard let cell = cell else { return UICollectionViewCell.init() }
            cell.data = self.data?.movies[indexPath.row]
            return cell
        }
    }
    
    private func createLayout() {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.28),
                heightDimension: .fractionalHeight(1)), repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20)
        let layout = UICollectionViewCompositionalLayout(section: section)
        cvCarousel.setCollectionViewLayout(layout, animated: true)
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MovieVO>()
        snapshot.appendSections([0])
        snapshot.appendItems(data?.movies ?? [], toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension  CarouselCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = data?.movies[indexPath.row]
        guard let movie = movie else { return }
        self.delegate?.onClickCarouselItem(movie: movie)
    }
}


