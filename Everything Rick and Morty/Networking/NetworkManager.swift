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
                      status: String,
                      species: String,
                      type: String,
                      page: String,
                      completion: @escaping ([Character], Info) -> Void) {

        provider.request(.character(name: name, status: status, species: species, type: type, page: page), completion: { result in
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
                print(error.localizedDescription)

            }
        })
    }

    func getLocation(completion: @escaping ([Location]) -> Void) {
    }

    func getEpisode(completion: @escaping ([Episode]) -> Void) {
    }
}