//
//  RickView.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 10/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class RickView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10

        layer.shadowColor = UIColor.rickAndMortyTitleGreen.cgColor
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize.zero
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 0.5
        layer.masksToBounds = false


    }

}
