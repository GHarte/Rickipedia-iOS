//
// Created by Gareth Harte on 07/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<RickAndMortyAPI> { get }
    func getCharacter(name: String,
                      page: String,
                      completion: @escaping ([Character], Info) -> Void)
    func getCharactersWith(ids: String,
                           completion: @escaping ([Character]) -> Void)
    func getLocation(name: String,
                     page: String,
                     completion: @escaping ([Location], Info) -> Void)
    func getEpisode(name: String,
                    page: String,
                    completion: @escaping ([Episode], Info) -> Void)
}
