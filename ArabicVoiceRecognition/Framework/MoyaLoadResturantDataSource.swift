//
//  MoyaLoadResturantDataSource.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import Moya


class MoyaLoadResturantDataSource: LoadResturantDataSource {
    private let provider = MoyaProvider<ResturantApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func loadResturat(area: String, searchText: String) -> Single<ResturantResponce> {
        return provider.rx
            .request(.getFeed(area, searchText))
            .map{
                try JSONDecoder().decode(ResturantResponce.self, from: $0.data)
        }
    }
}
