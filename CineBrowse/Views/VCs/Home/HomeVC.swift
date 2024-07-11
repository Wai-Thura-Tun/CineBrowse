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
        self.vm.updateMovieLists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tblMovies.reloadData()
    }
    
    private func setUpViews() {
        btnSearch.addShadow()
        tblMovies.separatorStyle = .none
        tblMovies.showsVerticalScrollIndicator = false
        tblMovies.dataSource = self
        tblMovies.delegate = self
        tblMovies.register(UINib.init(nibName: "BannerCell", bundle: nil), forCellReuseIdentifier: "BannerCell")
        tblMovies.register(UINib.init(nibName: "CarouselCell", bundle: nil), forCellReuseIdentifier: "CarouselCell")
        tblMovies.refreshControl = refreshControl
    }
    
    private func setUpBindings() {
        btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(onScrollRefresh), for: .valueChanged)
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

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.movieLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.vm.movieLists[indexPath.row]
        switch data.type {
        case MovieListType.nowPlaying.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as? BannerCell
            guard let cell = cell else { return UITableViewCell.init() }
            cell.data = data
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselCell") as? CarouselCell
            guard let cell = cell else { return UITableViewCell.init() }
            cell.data = data
            cell.delegate = self
            return cell
        }
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: HomeViewDelegate {
    func onLoadMovies() {
        self.tblMovies.reloadData()
    }
    
    func onError(error: String) {
        print(error)
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
