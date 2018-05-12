//
//  RickImageView.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 10/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class RickImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

}
