//
//  CharacterListViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentPageLabel: UILabel!
    
    let networkManager = NetworkManager()
    var characters = [Character]() {
        didSet {
            tableView.reloadData()
        }
    }
    var info: Info? {
        didSet {
            currentPageLabel.text = info?.currentPage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = .mainBackgroundColor
        makeCharacterRequest(name: "", status: "", species: "", type: "", page: "")

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toCharacterDetailVC" {
            if let characterDetailVC = segue.destination as? CharacterDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    characterDetailVC.character = characters[indexPath.row]
                }
            }
        }
    }

    func makeCharacterRequest(name: String, status: String, species: String, type: String, page: String) {
        networkManager.getCharacter(name: name, status: status, species: species, type: type, page: page) { characters, info in
            self.characters = characters
            self.info = info
        }
    }

    @IBAction func previousButtonPressed(_ sender: UIButton) {

        guard let previous = info?.previousPage() else {
            return
        }

        if previous != "" {
            makeCharacterRequest(name: "", status: "", species: "", type: "", page: previous)
        }

    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {

        guard let next = info?.nextPage() else {
            return
        }

        if next != "" {
            makeCharacterRequest(name: "", status: "", species: "", type: "", page: next)
        }

    }

}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.setUpWith(characterModel: character)
        return cell
    }
}

extension CharacterListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCharacterDetailVC", sender: self)
    }
}

