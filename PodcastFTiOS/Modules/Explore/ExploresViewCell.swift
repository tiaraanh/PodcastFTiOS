//
//  ExploresViewCell.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 16/11/22.
//

import UIKit

class ExploresViewCell: UITableViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
