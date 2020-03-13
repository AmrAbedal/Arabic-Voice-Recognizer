//
//  LoadResturantDataSource.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift

protocol LoadResturantDataSource {
    func loadResturat(area: String,searchText: String) -> Single<ResturantResponce>
}
