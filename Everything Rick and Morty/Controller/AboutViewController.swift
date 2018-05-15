//
//  AboutViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 14/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit
import AcknowList

class AboutViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var versionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = .mainBackgroundColor
        view.backgroundColor = .mainColor
        tableView.backgroundColor = .mainBackgroundColor

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "v"+version
        }

    }

}

extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell") else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "View Source Code on Github"
        case 1:
            cell.textLabel?.text = "Open Source Libraries Used"
        case 2:
            cell.textLabel?.text = "App icon - icons8.com"
        case 3:
            cell.textLabel?.text = "Get Schwifty font by Jonizaak on DeviantArt"
        default:
            cell.textLabel?.text = ""
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let url = URL(string: "https://github.com/GHarte/Rickipedia-iOS") {
                UIApplication.shared.open(url)
            }
        case 1:
            let vc = AcknowListViewController()
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            if let url = URL(string: "https://icons8.com/") {
                UIApplication.shared.open(url)
            }
        case 3:
            if let url = URL(string: "https://jonizaak.deviantart.com/art/Get-Schwifty-A-Rick-and-Morty-font-638073728") {
                UIApplication.shared.open(url)
            }
        default:
            break
        }
    }
}
