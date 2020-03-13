//
//  ResturantApi.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/14/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation

enum ResturantApi {
    case loadResturant(String,String)
    case getLocations(area: String)
    case getFeed(String,String)
}
