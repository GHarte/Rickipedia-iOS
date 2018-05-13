//
//  EpisodeListViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class EpisodeListViewController: BaseListViewController {
    
    let networkManager = NetworkManager()
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeEpisodeRequest(name: "", page: "")
    }

    func makeEpisodeRequest(name: String, page: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        networkManager.getEpisode(name: name, page: page) { episodes, info in
            self.episodes = episodes
            self.info = info
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toEpisodeDetailVC" {
            if let episodeDetailVC = segue.destination as? EpisodeDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    episodeDetailVC.episode = episodes[indexPath.row]
                }
            }
        }
    }

    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)
        guard let text = searchController.searchBar.text else {
            return
        }
        makeEpisodeRequest(name:text, page: "")
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        guard let previous = info?.previousPage() else {
            return
        }
        
        if previous != "" {
            makeEpisodeRequest(name: "", page: previous)
        }
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard let next = info?.nextPage() else {
            return
        }
        
        if next != "" {
            makeEpisodeRequest(name: "", page: next)
        }
    }
    
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEpisodeDetailVC", sender: self)
    }
}

extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: EpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        let episode = episodes[indexPath.row]
        cell.setUpWith(episodeModel: episode)
        return cell
    }
}
