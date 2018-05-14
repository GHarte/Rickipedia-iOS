//
// Created by Gareth Harte on 07/05/2018.
// Copyright (c) 2018 gharte. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import KRProgressHUD

enum NetworkStrings {
    static let loading = "Loading..."
    static let genericErrorMessage = "Something went wrong, please try again"
    static let noConnection = "You appear to be offline, please connect to the internet"
}

struct NetworkManager: Networkable {

    var provider = MoyaProvider<RickAndMortyAPI>()

    func getCharacter(name: String,
                      page: String,
                      completion: @escaping ([Character]?, Info?) -> Void) {

        provider.request(.character(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CharacterResponse.self, from: response.data)
                    completion(results.results, results.info)
                    KRProgressHUD.dismiss()
                }
                catch let error {
                    print(error.localizedDescription)
                    completion(nil, nil)
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        KRProgressHUD.showError(withMessage: NetworkStrings.noConnection)
                    }
                }
                else {
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
                completion(nil, nil)
                print(error.localizedDescription)
            }
        })
    }

    func getCharactersWith(ids: String, completion: @escaping ([Character]?) -> Void) {

        KRProgressHUD.show(withMessage: NetworkStrings.loading)
        provider.request(.charactersWith(ids: ids), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Character].self, from: response.data)
                    completion(results)
                    KRProgressHUD.dismiss()
                }
                catch let error {
                    print(error.localizedDescription)
                    completion(nil)
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        KRProgressHUD.showError(withMessage: NetworkStrings.noConnection)
                    }
                }
                else {
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
                completion(nil)
                print(error.localizedDescription)
            }
        })
    }

    func getLocation(name: String,
                     page: String,
                     completion: @escaping ([Location]?, Info?) -> Void) {

        KRProgressHUD.show(withMessage: NetworkStrings.loading)
        provider.request(.location(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(LocationResponse.self, from: response.data)
                    completion(results.results, results.info)
                    KRProgressHUD.dismiss()
                }
                catch let error {
                    print(error.localizedDescription)
                    completion(nil, nil)
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        KRProgressHUD.showError(withMessage: NetworkStrings.noConnection)
                    }
                }
                else {
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
                completion(nil, nil)
                print(error.localizedDescription)
            }
        })

    }

    func getEpisode(name: String,
                    page: String,
                    completion: @escaping ([Episode]?, Info?) -> Void) {

        KRProgressHUD.show(withMessage: NetworkStrings.loading)
        provider.request(.episode(name: name, page: page), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(EpisodeResponse.self, from: response.data)
                    completion(results.results, results.info)
                    KRProgressHUD.dismiss()
                }
                catch let error {
                    print(error.localizedDescription)
                    completion(nil, nil)
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
            case let .failure(error):

                if let reachabilityManger = NetworkReachabilityManager(){
                    if !reachabilityManger.isReachable {
                        KRProgressHUD.showError(withMessage: NetworkStrings.noConnection)
                    }
                }
                else {
                    KRProgressHUD.showError(withMessage: NetworkStrings.genericErrorMessage)
                }
                completion(nil, nil)
                print(error.localizedDescription)
            }
        })

    }
}
