//
//  MediaCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import UIKit

class MediaCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBar: UIView!
    
    var data: MediaType? {
        didSet {
            if let data = data {
                lblTitle.text = data.rawValue
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            viewBar.isHidden = !isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
