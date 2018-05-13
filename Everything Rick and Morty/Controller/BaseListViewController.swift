//
//  BaseListViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 13/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

class BaseListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentPageLabel: UILabel!
    @IBOutlet var paginationHeightContraint: NSLayoutConstraint!
    @IBOutlet var paginationStackView: UIStackView!
    
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
        view.backgroundColor = .mainColor
        configureSearchBar()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainBackgroundColor
    }

    private func configureSearchBar() {
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

}

extension BaseListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        paginationHeightContraint.constant = text == "" ? 30.0 : 0.0
        paginationStackView.isHidden = text == "" ? false : true
    }
}
