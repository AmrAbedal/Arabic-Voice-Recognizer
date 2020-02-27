//
//  AppleAreaNameCapture.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 2/26/20.
//  Copyright © 2020 Orcas. All rights reserved.
//


import Foundation
import CoreLocation

class AppleAreaNameCapture: AreaNameCapture {
    private var locationCapture: LocationCapture
    var onlyOne: Bool = true
    init(locationCapture: LocationCapture) {
        self.locationCapture = locationCapture
    }
    func getAreaName(onlyOne: Bool = true, completion:@escaping(String) -> ()) {
        self.onlyOne = onlyOne
        locationCapture.getLocation(completion: {
            location in
            let geocoder = CLGeocoder()
                        geocoder.reverseGeocodeLocation(location) { placemarks, error in
                            if let areaName = placemarks?.first?.locality  ?? placemarks?.first?.administrativeArea {
                                if self.onlyOne {
                                     completion(areaName)
                                    self.onlyOne = false
                                } else {
                                    
                                }
                               
                            } else {
                                
                            }
                        }
        })
    }
}
