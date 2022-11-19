//
//  DownloadViewCell.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 12/11/22.
//

import UIKit

class DownloadViewCell: UITableViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
