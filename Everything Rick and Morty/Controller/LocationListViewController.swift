//
//  LocationListViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit
import KRProgressHUD

class LocationListViewController: BaseListViewController {

    let networkManager = NetworkManager()
    var locations = [Location]() {
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
        makeLocationRequest(name: "", page: "")
    }

    func makeLocationRequest(name: String, page: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        networkManager.getLocation(name: name, page: page) { locations, info in
            if let locations = locations {
                self.locations = locations
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
            makeLocationRequest(name: text, page: page)
        }
    }

    override func handleRefresh(refreshControl: UIRefreshControl) {
        super.handleRefresh(refreshControl: refreshControl)
        if let page = info?.currentPage() {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeLocationRequest(name: "", page: page)
        }
        else {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeLocationRequest(name: "", page: "")
        }
    }

    @IBAction func previousButtonPressed(_ sender: UIButton) {
        guard let previous = info?.previousPage() else {
            return
        }
        
        if previous != "" {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeLocationRequest(name: "", page: previous)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard let next = info?.nextPage() else {
            return
        }
        
        if next != "" {
            KRProgressHUD.show(withMessage: NetworkStrings.loading, completion: nil)
            makeLocationRequest(name: "", page: next)
        }
    }
    
}

extension LocationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LocationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let location = locations[indexPath.row]
        cell.setUpWith(locationModel: location)
        return cell
    }
}
