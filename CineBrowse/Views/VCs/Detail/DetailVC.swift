import UIKit
import WebKit
import AVKit

class DetailVC: UIViewController, Storyboarded, WKNavigationDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var viewReleaseDate: UIView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var viewTblTV: UIView!
    @IBOutlet weak var tblTV: UITableView!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var tblCastAndRelated: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    static var storyboardName: String = "Home"
    
    var movie: MovieVO!
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    private lazy var vm: DetailVM = .init(delegate: self)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpBindings()
        self.vm.getDetail(movie: movie)
    }
    
    private func setUpViews() {
        setUpWebView()
        setUpProgressView()
        viewReleaseDate.addBorder()
        viewRating.addBorder()
        setUpTblTV()
        setUpTblCastAndRelated()
    }
    
    private func setUpBindings() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }
    
    private func setUpTblTV() {
        tblTV.register(UINib.init(nibName: "SeasonEpisodeCell", bundle: nil), forCellReuseIdentifier: "SeasonEpisodeCell")
        tblTV.dataSource = self
        tblTV.delegate = self
        tblTV.separatorStyle = .none
        viewTblTV.isHidden = movie.isMovie
    }
    
    private func setUpTblCastAndRelated() {
        tblCastAndRelated.register(UINib.init(nibName: "CastCell", bundle: nil), forCellReuseIdentifier: "CastCell")
        tblCastAndRelated.register(UINib.init(nibName: "CarouselCell", bundle: nil), forCellReuseIdentifier: "CarouselCell")
        tblCastAndRelated.dataSource = self
        tblCastAndRelated.delegate = self
        tblCastAndRelated.separatorStyle = .none
    }
    
    private func setUpWebView() {
        webView = WKWebView(frame: self.viewVideo.frame)
        webView.backgroundColor = .black
        webView.scrollView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.configuration.preferences.isElementFullscreenEnabled = true
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.allowsPictureInPictureMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = .audio
        webView.navigationDelegate =  self
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.viewVideo.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: viewVideo.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: viewVideo.trailingAnchor),
            webView.topAnchor.constraint(equalTo:
                viewVideo.topAnchor),
            webView.bottomAnchor.constraint(equalTo:
                viewVideo.bottomAnchor)
        ])
    }
    
    private func setUpProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.tintColor = .white
        self.viewVideo.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: viewVideo.centerXAnchor),
            progressView.widthAnchor.constraint(equalTo: viewVideo.widthAnchor),
            progressView.bottomAnchor.constraint(equalTo: viewVideo.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    @objc func onTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
            }
        }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.isHidden = true
        progressView.isHidden = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = false
        progressView.isHidden = true
    }

    private func loadVideo(urlRequest: URLRequest?) {
        guard let request = urlRequest else { return }
        webView.load(request)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
}

extension DetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = self.vm.detail?.detail
        if tableView == tblTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonEpisodeCell") as? SeasonEpisodeCell
            guard let cell = cell else { return UITableViewCell.init() }
            if indexPath.row == 0 {
                cell.isEpisode = false
                cell.selectedIndex = self.vm.currentSeason
                cell.itemCount = detail?.seasons?.count ?? 0
            }
            else {
                cell.isEpisode = true
                cell.selectedIndex = self.vm.currentEpisode
                cell.itemCount = detail?.seasons?[self.vm.currentSeason].episodeCount ?? 0
            }
            cell.delegate = self
            return cell
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as? CastCell
                guard let cell = cell else { return UITableViewCell.init() }
                cell.data = self.vm.detail?.credit.cast
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselCell", for: indexPath) as? CarouselCell
            guard let cell = cell else { return UITableViewCell.init() }
            cell.data = self.vm.detail?.related
            cell.delegate = self
            return cell
        }
    }
}

extension DetailVC: UITableViewDelegate {
    
}

extension DetailVC: DetailViewDelegate {
    
    func onLoadVideo(urlRequest: URLRequest?) {
        self.tblTV.reloadData()
        self.loadVideo(urlRequest: urlRequest)
    }
    
    func onLoadDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.tblTV.reloadData()
            self?.tblCastAndRelated.reloadData()
            self?.bindData()
        }
    }
    
    func onError(error: String) {
        
    }
    
    private func bindData() {
        if let detail = self.vm.detail?.detail {
            lblTitle.text = detail.title ?? detail.originalTitle ?? detail.name
            if let date = detail.releaseDate {
                lblReleaseDate.text = String(date.prefix(4))
            }
            lblRating.text = String(format: "%.1f", detail.voteAverage ?? 0.0)
            lblOverview.text = detail.overview
            loadVideo(urlRequest: self.vm.videoURLRequest)
        }
    }
}

extension DetailVC: SeasonEpisodeCellDelegate {
    func onTapSeason(id: Int) {
        self.vm.setCurrentSeason(season: id)
    }
    
    func onTapEpisode(id: Int) {
        self.vm.setCurrentEpisode(episode: id)
    }
}

extension DetailVC: CarouselCellDelegate {
    func onClickCarouselItem(movie: MovieVO) {
        self.movie = movie
        self.vm.getDetail(movie: movie)
        self.vm.resetSeasonAndEpisode()
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
