//
//  CarouselItemCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import UIKit

class CarouselItemCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCarousel: UIImageView!
    
    var data: MovieVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.title
                imgCarousel.setImage(path: data.posterUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
