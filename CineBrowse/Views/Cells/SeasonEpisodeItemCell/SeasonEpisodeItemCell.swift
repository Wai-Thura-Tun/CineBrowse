//
//  SeasonEpisodeItemCell.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/10/24.
//

import UIKit

class SeasonEpisodeItemCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    
    var data: Int = 0 {
        didSet {
            lblNumber.text = String(data)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            lblNumber.textColor = isSelected ? .red : .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContainer.addBorder()
    }
}
