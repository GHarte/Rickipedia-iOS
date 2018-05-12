//
//  CharacterDetailViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 10/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.sd_setImage(with: URL(string: (character?.image)!), completed: nil)
        title = character?.name
        statusLabel.text = character?.status
        speciesLabel.text = character?.species
        typeLabel.text = character?.type == "" ? "Not Available" : character?.type
        originLabel.text = character?.origin.name
        locationLabel.text = character?.location.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
