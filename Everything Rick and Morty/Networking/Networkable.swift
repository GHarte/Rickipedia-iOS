//
// Created by Gareth Harte on 07/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<RickAndMortyAPI> { get }
    func getCharacter(name: String,
                      status: String,
                      species: String,
                      type: String,
                      page: String,
                      completion: @escaping ([Character], Info) -> Void)
    func getLocation(completion: @escaping ([Location]) -> Void)
    func getEpisode(completion: @escaping ([Episode]) -> Void)
}
