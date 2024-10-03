//
//  BannerCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import UIKit

protocol BannerCellDelegate: AnyObject {
    func onClickBannerItem(movie: MovieVO)
}

class BannerCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvBanner: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var data: MovieListVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.type
                pageControl.numberOfPages = data.movies.count
                updateSnapShot()
                startAutoScroll()
            }
        }
    }
    
    weak var delegate: BannerCellDelegate?
    var timer: Timer?
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
        self.selectionStyle = .none
    }
    
    private func setUpViews() {
        cvBanner.delegate = self
        cvBanner.register(UINib.init(nibName: "BannerItemCell", bundle: nil), forCellWithReuseIdentifier: "BannerItemCell")
    }
    
    private func createLayout() {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: item, count: 1
        )
        
        group.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            let page = Int(offset.x / self.cvBanner.bounds.width)
            self.pageControl.currentPage = page
        }
        let layout = UICollectionViewCompositionalLayout(section: section)
        cvBanner.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.cvBanner) { collectionView, indexPath, movieVO in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerItemCell", for: indexPath) as? BannerItemCell
            guard let cell = cell else { return UICollectionViewCell.init() }
            cell.data = movieVO
            return cell
        }
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MovieVO>()
        snapshot.appendSections([0])
        snapshot.appendItems(data?.movies ?? [], toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNextItem() {
        guard let cvBanner = cvBanner else { return }
            
        let visibleItems = cvBanner.indexPathsForVisibleItems
        if let currentIndexPath = visibleItems.first {
            var nextItem = currentIndexPath.item + 1
                
            if nextItem == data?.movies.count {
                nextItem = 0
            }
                
            let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
            cvBanner.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        stopAutoScroll()
    }
    
    deinit {
        stopAutoScroll()
    }
}

extension BannerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.isSelected = false
            cell.isHighlighted = false
        }
        let movie = data?.movies[indexPath.row]
        guard let movie = movie else { return }
        stopAutoScroll()
        self.delegate?.onClickBannerItem(movie: movie)
    }
}
