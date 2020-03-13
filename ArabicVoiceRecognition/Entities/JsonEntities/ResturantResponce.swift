//
//  ResturantResponce.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation


struct ResturantResponce: Codable {
    let data: ResponceData
}
struct ResponceData: Codable {
    let storesMap: [String: Store]
}

struct Store: Codable {
    let title: String
    let heroImageUrl: String
}
