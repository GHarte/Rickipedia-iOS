//
//  LocationTableViewCell.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 13/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dimensionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setUpWith(locationModel location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
    }
    
}
