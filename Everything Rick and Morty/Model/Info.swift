//
// Created by Gareth Harte on 06/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String
}