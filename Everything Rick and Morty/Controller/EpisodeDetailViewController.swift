//
//  EpisodeDetailViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 13/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var airDateLabel: UILabel!
    @IBOutlet var episodeLabel: UILabel!
    @IBOutlet var charactersLabel: UILabel!

    var episode: Episode?
    var characters = [Character]() {
        didSet {
            tableView.reloadData()
        }
    }
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeCharactersRequest()
        title = episode?.name
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainBackgroundColor
    }

    func makeCharactersRequest() {
        if let characterIds = episode?.characterIds() {
            networkManager.getCharactersWith(ids: characterIds) { characters in
                self.characters = characters
            }
        }
    }

    func characterNamesAsString() -> String {
        var characterNames = ""
        for character in characters {
            characterNames.append(character.name + " \n")
        }
        return characterNames
    }

}

extension EpisodeDetailViewController: UITableViewDelegate {

}

extension EpisodeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? DetailTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.detailTypeLabel.text = "Air Date:"
            cell.detailInfoLabel.text = episode?.airDate
        case 1:
            cell.detailTypeLabel.text = "Episode:"
            cell.detailInfoLabel.text = episode?.episode
        case 2:
            cell.detailTypeLabel.text = "Characters:"
            cell.detailInfoLabel.text = characterNamesAsString()
        default:
            return UITableViewCell()
        }
        return cell
    }
}
