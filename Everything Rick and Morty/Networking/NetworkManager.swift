//
// Created by Gareth Harte on 07/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya
import Alamofire

struct NetworkManager: Networkable {

    var provider = MoyaProvider<RickAndMortyAPI>()

    func getCharacter(name: String,
                      page: String,
                      completion: @escaping ([Character], Info) -> Void) {

        provider.request(.character(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CharacterResponse.self, from: response.data)
                    completion(results.results, results.info)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        print("offline")
                    }
                }

                print(error.localizedDescription)
            }
        })
    }

    func getCharactersWith(ids: String, completion: @escaping ([Character]) -> Void) {
        provider.request(.charactersWith(ids: ids), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Character].self, from: response.data)
                    completion(results)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        print("offline")
                    }
                }

                print(error.localizedDescription)
            }
        })
    }

    func getLocation(name: String,
                     page: String,
                     completion: @escaping ([Location], Info) -> Void) {

        provider.request(.location(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(LocationResponse.self, from: response.data)
                    completion(results.results, results.info)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        print("offline")
                    }
                }

                print(error.localizedDescription)
            }
        })

    }

    func getEpisode(name: String,
                    page: String,
                    completion: @escaping ([Episode], Info) -> Void) {

        provider.request(.episode(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(EpisodeResponse.self, from: response.data)
                    completion(results.results, results.info)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        print("offline")
                    }
                }

                print(error.localizedDescription)
            }
        })

    }
}
