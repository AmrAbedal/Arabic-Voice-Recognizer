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
    func getAreaName(locationCapture: LocationCapture, completion: @escaping (String)->() )
}

class AppleAreaNameCapture: AreaNameCapture {
    func getAreaName(locationCapture: LocationCapture, completion:@escaping(String) -> ()) {
        locationCapture.getLocation(completion: {
            location in
            let geocoder = CLGeocoder()
                        geocoder.reverseGeocodeLocation(location) { placemarks, error in
                            if let areaName = placemarks?.first?.administrativeArea {
                                completion(areaName)
                            } else {
                                
                            }
                        }
        })
    }
}
