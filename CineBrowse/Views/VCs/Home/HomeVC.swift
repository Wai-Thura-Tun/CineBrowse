//
//  HomeVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tblMovies: UITableView!
    
    static var storyboardName: String = "Home"
    
    private lazy var vm: HomeVM = .init(delegate: self)
    
    private let refreshControl = UIRefreshControl()
    
    private var dataSource: UITableViewDiffableDataSource<Int, MovieListVO>!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tabBarItem = UITabBarItem.init(
            title: "Home",
            image: UIImage(systemName: "house") ,
            tag: 1
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBindings()
        setUpDataSource()
        self.vm.updateMovieLists()
    }
    
    private func setUpViews() {
        btnSearch.addShadow(color: .white, radius: 6)
        tblMovies.separatorStyle = .none
        tblMovies.showsVerticalScrollIndicator = false
        refreshControl.tintColor = .white
        tblMovies.refreshControl = refreshControl
    }
    
    private func setUpBindings() {
        btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(onScrollRefresh), for: .valueChanged)
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tblMovies) { tableView, indexPath, movieListVO in
            let data = movieListVO
            switch data.type {
            case MovieListType.nowPlaying.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as? BannerCell
                guard let cell = cell else { return UITableViewCell.init() }
                cell.data = data
                cell.delegate = self
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselCell", for: indexPath) as? CarouselCell
                guard let cell = cell else { return UITableViewCell.init() }
                cell.data = data
                cell.delegate = self
                return cell
            }
        }
        tblMovies.register(UINib.init(nibName: "BannerCell", bundle: nil), forCellReuseIdentifier: "BannerCell")
        tblMovies.register(UINib.init(nibName: "CarouselCell", bundle: nil), forCellReuseIdentifier: "CarouselCell")
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MovieListVO>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.vm.movieLists, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func onTapSearch() {
        let vc = SearchVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func onScrollRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.vm.updateMovieLists()
            self.tblMovies.refreshControl?.endRefreshing()
        }
    }
}

extension HomeVC: HomeViewDelegate {
    func onLoadMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.updateSnapShot()
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showOkAlert(title: "Error", message: "Something went wrong")
        }
    }
}

extension HomeVC: BannerCellDelegate {
    func onClickBannerItem(movie: MovieVO) {
        let vc = DetailVC.instantiate()
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: CarouselCellDelegate {
    func onClickCarouselItem(movie: MovieVO) {
        let vc = DetailVC.instantiate()
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
