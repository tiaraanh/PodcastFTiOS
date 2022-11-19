//
//  EpisodeViewCell.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 12/11/22.
//

import UIKit

class EpisodeViewCell: UITableViewCell {

    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 6
        thumbImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
