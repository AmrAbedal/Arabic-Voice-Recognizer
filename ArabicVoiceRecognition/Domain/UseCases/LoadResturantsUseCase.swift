//
//  LoadResturantsUseCase.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/11/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import Moya



func loadResturantsUseCase(dataSource: LoadResturantDataSource,area: String,searchText: String) -> Single <[Resturant]>{
    return dataSource.loadResturat(area: area, searchText: searchText).map({
        getResturantFrom(resturantResponce: $0)
    })
}

fileprivate func getResturantFrom(resturantResponce: ResturantResponce) -> [Resturant] {
    return resturantResponce.data.storesMap.map({Resturant(name: $0.value.title, image: $0.value.heroImageUrl)})
}


