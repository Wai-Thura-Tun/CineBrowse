//
//  BannerItemCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import UIKit

class BannerItemCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    
    var data: MovieVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.title
                imgBanner.setImage(path: data.posterUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
