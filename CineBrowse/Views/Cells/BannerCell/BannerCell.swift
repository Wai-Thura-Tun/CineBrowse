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
                self.cvBanner.reloadData()
                startAutoScroll()
            }
        }
    }
    
    weak var delegate: BannerCellDelegate?
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        setUpViews()
        createLayout()
    }
    
    private func setUpViews() {
        cvBanner.dataSource = self
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

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerItemCell", for: indexPath) as? BannerItemCell
        guard let cell = cell else { return UICollectionViewCell.init() }
        cell.data = data?.movies[indexPath.row]
        return cell
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
