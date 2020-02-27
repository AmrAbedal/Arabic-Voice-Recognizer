//
//  AreaNameCapture.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 2/26/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import CoreLocation

protocol AreaNameCapture {
    func getAreaName(onlyOne: Bool,completion: @escaping (String)->() )
}
