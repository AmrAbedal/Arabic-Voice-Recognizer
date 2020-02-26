//
//  LocationCapture.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 2/26/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationCapture {
    func getLocation(completion: @escaping (CLLocation)->())
}
