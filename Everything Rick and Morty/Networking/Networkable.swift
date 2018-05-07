//
// Created by Gareth Harte on 07/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<RickAndMortyAPI> { get }
    func getCharacter(completion: @escaping ([Character]) -> Void)
    func getLocation(completion: @escaping ([Location]) -> Void)
    func getEpisode(completion: @escaping ([Episode]) -> Void)
}
