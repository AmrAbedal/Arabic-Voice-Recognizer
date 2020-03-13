//
//  loadLocationUseCae.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift

func loadLocationUseCae(loadLocatinostDataSource: LoadLocatinostDataSource ,areaName: String ) -> Single<[LocatinoScreenData]> {
    
    return loadLocatinostDataSource.loadLocation(area: areaName).map({
        getLocationScreenData(from:$0)
    })
    
}

fileprivate func getLocationScreenData(from: LocationResponce ) -> [LocatinoScreenData] {
    return from.data.map({
        LocatinoScreenData(id: $0.id, addressLine1: $0.addressLine1, addressLine2: $0.addressLine2)
    })
}
