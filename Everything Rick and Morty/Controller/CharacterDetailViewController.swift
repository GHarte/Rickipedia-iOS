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

    @IBOutlet var tableView: UITableView!

    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()

        characterImageView.sd_setImage(with: URL(string: (character?.image)!), completed: nil)
        title = character?.name
        tableView.backgroundColor = .mainBackgroundColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
            cell.textLabel?.text = character?.status
        case 1:
            cell.textLabel?.text = character?.species
        case 2:
            cell.textLabel?.text = character?.type
        case 3:
            cell.textLabel?.text = character?.origin.name
        case 4:
            cell.textLabel?.text = character?.location.name
        default:
            break
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
            label.text = "Status"
        case 1:
            label.text = "Species"
        case 2:
            label.text = "Sub Species"
        case 3:
            label.text = "Origin"
        case 4:
            label.text = "Location"
        default:
            break
        }

        return view
    }
}

extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if character?.type == "" || character?.type == nil {
            if section == 2{
                return 0
            }
        }
        return 28.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if character?.type == "" || character?.type == nil {
            if indexPath.section == 2{
                return 0
            }
        }
        return 50
    }
}
