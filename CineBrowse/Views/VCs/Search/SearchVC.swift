//
//  SearchVC.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import UIKit

class SearchVC: UIViewController, Storyboarded {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var cvMediaType: UICollectionView!
    @IBOutlet weak var tblSearchList: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewNotFound: UIView!
    
    static var storyboardName: String = "Home"
    
    private lazy var vm: SearchVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBindings()
    }
    
    private func setUpViews() {
        cvMediaType.dataSource = self
        cvMediaType.delegate = self
        cvMediaType.register(UINib.init(nibName: "MediaCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
        cvMediaType.selectItem(
            at: IndexPath.init(row: 0, section: 0),
            animated: true,
            scrollPosition: .left
        )
        tblSearchList.dataSource = self
        tblSearchList.delegate = self
        tblSearchList.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tblSearchList.separatorStyle = .none
    }
    
    private func setUpBindings() {
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        tfSearch.addTarget(self, action: #selector(onChangeSearch), for: .editingChanged)
        btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
    }
    
    @objc func onTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onChangeSearch() {
        self.vm.setSearchString(searchString: tfSearch.text)
    }
    
    @objc func onTapSearch() {
        self.loadingIndicator.startAnimating()
        self.vm.searchMovieOrTV()
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MediaType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as? MediaCell
        guard let cell = cell else { return UICollectionViewCell.init() }
        cell.data = MediaType.allCases[indexPath.row]
        return cell
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm.setIsMovie(isMovie: indexPath.row == 0)
        self.loadingIndicator.startAnimating()
        self.vm.searchMovieOrTV()
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width / 2, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.searchResult?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell
        guard let cell = cell else { return UITableViewCell.init() }
        let movie = self.vm.searchResult?.movies[indexPath.row]
        cell.data = (movie, self.vm.searchResult?.genres)
        cell.delegate = self
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    
}

extension SearchVC: SearchViewDelegate {
    func onLoadSearchResult() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.tblSearchList.reloadData()
            if let movies = self?.vm.searchResult?.movies, movies.count <= 0 {
                self?.viewNotFound.isHidden = false
                self?.tblSearchList.isHidden = true
            }
            else {
                self?.viewNotFound.isHidden = true
                self?.tblSearchList.isHidden = false
            }
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.showOkAlert(title: "Error", message: "Something went wrong. Check your connection and try again!")
        }
    }
}

extension SearchVC: SearchCellDelegate {
    func onTapWatch(movie: MovieDataVO) {
        let movieVO = movie.toVO(type: .action, isMovie: self.vm.isMovie)
        let vc = DetailVC.instantiate()
        vc.movie = movieVO
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
