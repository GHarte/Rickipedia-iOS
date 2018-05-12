//
// Created by Gareth Harte on 06/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum RickAndMortyAPI {
    case character(name: String, status: String, species: String, type: String, page: String)
    case location(name: String, type: String, dimension: String)
    case episode(name: String, episode: String)
}

extension RickAndMortyAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Base URL could not be configured")
        }
        return url
    }
    var path: String {
        switch self {
        case .character:
            return "/character"
        case .location:
            return "/location"
        case .episode:
            return "/episode"
        default:
            return ""
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        //TODO: Add local JSON files
        switch self {
        default:
            return Data()
        }
    }
    var task: Task {
        switch self {
        case .character(let name, let status, let species, let type, let page):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "status": status,
                        "species": species,
                        "type": type,
                        "page": page
                    ],
                    encoding: URLEncoding.queryString)

        case .location(let name, let type, let dimension):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "type": type,
                        "dimension": dimension
                    ],
                    encoding: URLEncoding.queryString)

        case .episode(let name, let episode):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "episode": episode
                    ],
                    encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}