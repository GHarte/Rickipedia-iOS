//
//  DetailTableViewCell.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 13/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet var detailTypeLabel: UILabel!
    @IBOutlet var detailInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .mainBackgroundColor
    }

}
