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
    @IBOutlet var paginationHeightContraint: NSLayoutConstraint!
    @IBOutlet var paginationStackView: UIStackView!

    let networkManager = NetworkManager()
    var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    var info: Info? {
        didSet {
            DispatchQueue.main.async {
                self.currentPageLabel.text = self.info?.currentPage()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = .mainBackgroundColor
        makeCharacterRequest(name: "", page: "")

        setUpSearchBar()

    }

    private func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        let scb = searchController.searchBar
        scb.tintColor = .rickAndMortyTitleBlue
        scb.barTintColor = UIColor.white

        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {

                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;

            }
        }
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
            self.characters = characters
            self.info = info
        }
//        networkManager.getCharactersWith(ids: "1,132") { characters in
//            self.characters = characters
//        }
    }

    @IBAction func previousButtonPressed(_ sender: UIButton) {

        guard let previous = info?.previousPage() else {
            return
        }

        if previous != "" {
            makeCharacterRequest(name: "", page: previous)
        }

    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {

        guard let next = info?.nextPage() else {
            return
        }

        if next != "" {
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

extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        makeCharacterRequest(name: text, page: "")
        paginationHeightContraint.constant = text == "" ? 30.0 : 0.0
        paginationStackView.isHidden = text == "" ? false : true
    }
}
