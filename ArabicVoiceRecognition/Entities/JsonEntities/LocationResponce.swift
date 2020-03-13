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







