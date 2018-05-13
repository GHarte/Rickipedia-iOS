//
// Created by Gareth Harte on 06/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum RickAndMortyAPI {
    case character(name: String, page: String)
    case charactersWith(ids: String)
    case location(name: String, page: String)
    case episode(name: String, page: String)
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
        case .charactersWith(let ids):
            return "/character/\(ids)"
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
        case .character(let name, let page):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "page": page
                    ],
                    encoding: URLEncoding.queryString)

        case .charactersWith(_):
            return .requestParameters(
                    parameters: [:],
                    encoding: URLEncoding.queryString)

        case .location(let name, let page):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "page": page,
                    ],
                    encoding: URLEncoding.queryString)

        case .episode(let name, let page):
            return .requestParameters(
                    parameters: [
                        "name": name,
                        "page": page
                    ],
                    encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}
