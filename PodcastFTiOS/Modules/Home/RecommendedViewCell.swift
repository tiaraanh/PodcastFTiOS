//
//  RecommendedViewCell.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 12/11/22.
//

import UIKit

class RecommendedViewCell: UICollectionViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImageView.layer.cornerRadius = 12
        thumbImageView.layer.masksToBounds = true
        
        
    }
    
    
}
