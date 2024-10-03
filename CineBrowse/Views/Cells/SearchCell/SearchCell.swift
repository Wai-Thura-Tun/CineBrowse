//
//  SearchCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import UIKit


protocol SearchCellDelegate: AnyObject {
    func onTapWatch(movie: MovieDataVO)
}

class SearchCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblReleasedDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnWatch: UIButton!
    
    var data: (MovieDataVO?, [Int: String]?) {
        didSet {
            if let movie = data.0, let genres = data.1 {
                lblTitle.text = movie.originalTitle ?? movie.name ?? movie.title
                imgMovie.setImage(path: movie.posterPath ?? movie.backdropPath ?? "")
                if let date = movie.releaseDate {
                    lblReleasedDate.text = String(date.prefix(4))
                }
                lblRating.text = String(format: "%.1f", movie.voteAverage ?? 0.0)
                var genreText: String = ""
                movie.genreIDS.forEach {
                    genreText.append("\(genres[$0] ?? ""), ")
                }
                lblGenre.text = genreText
            }
        }
    }
    
    weak var delegate: SearchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpBindings()
    }
    
    private func setUpBindings() {
        btnWatch.addTarget(self, action: #selector(onTapWatch), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTapWatch() {
        if let movie = self.data.0 {
            self.delegate?.onTapWatch(movie: movie)
        }
    }
}
