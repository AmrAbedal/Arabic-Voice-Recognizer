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

class AppleCoreLocationCapture: NSObject, LocationCapture, CLLocationManagerDelegate {
    private var completion: ((CLLocation)->())? = nil
    private let locationManager = CLLocationManager()
      override  init() {
          super.init()
           self.locationManager.delegate = self
           self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
           self.locationManager.requestWhenInUseAuthorization()
           self.locationManager.startUpdatingLocation()
       }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
                   return
               }
             completion?(location)
        
    }
    func getLocation(completion: @escaping (CLLocation) -> ()) {
          self.completion = completion
      }
}

