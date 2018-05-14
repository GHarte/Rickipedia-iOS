//
//  AboutViewController.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 14/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import UIKit

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
        return 2
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
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                if let url = URL(string: "https://github.com/GHarte/Rickipedia-iOS") {
                    UIApplication.shared.openURL(url)
                }
            default:
            break
        }
    }
}
