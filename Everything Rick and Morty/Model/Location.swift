//
//  Location.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import Foundation

struct LocationResponse: Decodable {
    let info: Info
    let results: [Location]
}

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
