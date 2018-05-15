//
//  CharacterListViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit
import KRProgressHUD

class CharacterListViewController: BaseListViewController {

    let networkManager = NetworkManager()
    var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
        makeCharacterRequest(name: "", page: "")

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

    func makeCharacterRequest(name: String, page: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        networkManager.getCharacter(name: name, page: page) { characters, info in
            if let characters = characters {
                self.characters = characters
            }
            if let info = info {
                self.info = info
            }
            self.refreshControl.endRefreshing()
        }
    }

    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)
        guard let text = searchController.searchBar.text else {
            return
        }
        if let page = info?.currentPage() {
            makeCharacterRequest(name:text, page: page)
        }
    }

    override func handleRefresh(refreshControl: UIRefreshControl) {
        super.handleRefresh(refreshControl: refreshControl)
        if let page = info?.currentPage() {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeCharacterRequest(name: "", page: page)
        }
        else {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeCharacterRequest(name: "", page: "")
        }
    }

    @IBAction func previousButtonPressed(_ sender: UIButton) {

        guard let previous = info?.previousPage() else {
            return
        }

        if previous != "" {
            KRProgressHUD.show(withMessage: NetworkStrings.loading)
            makeCharacterRequest(name: "", page: previous)
        }

    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {

        guard let next = info?.nextPage() else {
            return
        }

        if next != "" {
            KRProgressHUD.show(withMessage: NetworkStrings.loading)
            makeCharacterRequest(name: "", page: next)
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