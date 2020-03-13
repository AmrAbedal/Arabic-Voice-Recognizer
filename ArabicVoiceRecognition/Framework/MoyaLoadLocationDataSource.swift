//
//  MoyaLoadLocationDataSource.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import Moya


class MoyaLoadLocationDataSource: LoadLocatinostDataSource {
    private let provider = MoyaProvider<ResturantApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    func loadLocation(area: String) -> Single<LocationResponce> {
        return provider.rx
            .request(.getLocations(area: area))
            .map{
                try JSONDecoder().decode(LocationResponce.self, from: $0.data)
        }
    }
}
