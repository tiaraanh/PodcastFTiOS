//
//  CollectionsViewCell.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 13/11/22.
//

import UIKit

class CollectionsViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
    }
}


