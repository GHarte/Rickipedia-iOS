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
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
    
    func characterIds() -> String {
        var ids = ""
        for characterUrl in characters {
            if let index = characterUrl.range(of: "character/")?.upperBound {
                let characterIdSubString = (characterUrl[index...])
                let characterId = String(characterIdSubString)
                ids.append(characterId + ",")
            }
        }
        return ids
    }
}
