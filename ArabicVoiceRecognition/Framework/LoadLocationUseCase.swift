//
//  LoadLocationUseCase.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/12/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import Moya


enum ResturantApi {
    case loadResturant(String,String)
    case getLocations(area: String)
    case getFeed(String,String)
}


struct LocationResponce: Codable {
    let data: [LocatinoData]
}
struct LocatinoData: Codable {
    let id: String
    let addressLine1: String
    let addressLine2: String
    
}
struct LocatinoScreenData {
    let id: String
    let addressLine1: String
    let addressLine2: String}



protocol LoadLocatinostDataSource {
    func loadLocation(area: String) -> Single<LocationResponce>
}

class MoyaLoadLocationDataSource: LoadLocatinostDataSource {
    func loadLocation(area: String) -> Single<LocationResponce> {
        return provider.rx
                         .request(.getLocations(area: area))
                         .map{
                             try JSONDecoder().decode(LocationResponce.self, from: $0.data)
                     }
    }
    private let provider = MoyaProvider<ResturantApi>(plugins: [NetworkLoggerPlugin(verbose: true)])

}

func loadLocationUseCae(loadLocatinostDataSource: LoadLocatinostDataSource ,areaName: String ) -> Single<[LocatinoScreenData]> {
    
    return loadLocatinostDataSource.loadLocation(area: areaName).map({
        getLocationScreenData(from:$0)
    })
    
}

func getLocationScreenData(from: LocationResponce ) -> [LocatinoScreenData] {
    return from.data.map({
        LocatinoScreenData(id: $0.id, addressLine1: $0.addressLine1, addressLine2: $0.addressLine2)
    })
}
