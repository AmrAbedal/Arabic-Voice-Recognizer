//
//  LoadLocatinostDataSource.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift

protocol LoadLocatinostDataSource {
    func loadLocation(area: String) -> Single<LocationResponce>
}
