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
                if let characters = characters {
                    self.characters = characters
                }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = episode?.airDate
        case 1:
            cell.textLabel?.text = episode?.episode
        case 2:
            cell.textLabel?.text = characterNamesAsString()
        default:
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = .mainColor
        cell.textLabel?.backgroundColor = .mainColor
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        let label = UILabel(frame: CGRect(x: 20, y:(view.frame.size.height / 2) - 4.5, width: tableView.frame.size.width, height: 20))
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .rickAndMortyTitleBlue
        view.addSubview(label)
        view.backgroundColor = .mainBackgroundColor

        switch section {
        case 0:
            label.text = "Air Date"
        case 1:
            label.text = "Episode"
        case 2:
            label.text = "Characters"
        default:
            break
        }

        return view
    }
}
