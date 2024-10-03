//
//  FavoriteCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import UIKit

class FavoriteCell: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var data: FavoriteVO? {
        didSet {
            if let data = data {
                self.lblTitle.text = data.title
                self.imgPoster.setImage(path: data.posterUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
