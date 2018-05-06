//
//  Episode.swift
//  Everything Rick and Morty
//
//  Created by Gareth Harte on 06/05/2018.
//  Copyright © 2018 gharte. All rights reserved.
//

import Foundation

struct EpisodeResponse: Decodable {
    let info: Info
    let results: [Episode]
}

struct Episode: Decodable {
    let id: String
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
