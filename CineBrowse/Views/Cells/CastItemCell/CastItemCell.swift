//
//  CastItemCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/10/24.
//

import UIKit

class CastItemCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCast: UIImageView!
    
    var data: CastVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.name
                imgCast.setImage(path: data.profilePath ?? "")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
