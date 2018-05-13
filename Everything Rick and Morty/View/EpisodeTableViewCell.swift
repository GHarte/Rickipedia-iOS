//
//  EpisodeTableViewCell.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 13/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var episodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setUpWith(episodeModel episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = episode.episode
    }
}
