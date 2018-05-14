//
//  CharacterTableViewCell.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 07/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setUpWith(characterModel character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        avatarImageView.sd_setImage(with: URL(string: character.image), completed: nil)
    }
    
}
