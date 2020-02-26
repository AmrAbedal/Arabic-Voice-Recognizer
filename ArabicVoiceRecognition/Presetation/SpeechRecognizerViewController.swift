//
//  SpeechRecognizerViewController.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import SwiftSoup
import CoreLocation

class SpeechRecognizerViewController: UIViewController {
    private var resturants: [String] = []
    @IBOutlet weak var ResturantTableView: UITableView!
    @IBOutlet weak var webView: WKWebView!
    let locationManager = LocationManager()
    private var disposeBag = DisposeBag()
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var searchUberEatsApi: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setSubscribers()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hanldeLocation()
    }
    private func hanldeLocation() {
        guard let exposedLocation = self.locationManager.exposedLocation else {
                   print("*** Error in \(#function): exposedLocation is nil")
                   return
               }
               
               self.locationManager.getPlace(for: exposedLocation) { placemark in
                guard let placemark = placemark else { return }
                print(placemark.areasOfInterest)
        }
    }
    private func setSubscribers() {
        viewModel.textChangeSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let text = elemnt {
                self?.setText(text: text)
            }
        }).disposed(by: disposeBag)
        viewModel.resturantListSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let resturantsNames = elemnt {
                self?.handleResturants(restrantsNames: resturantsNames)
            }
        }).disposed(by: disposeBag)
        viewModel.loadUrlSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let urlRequest = elemnt {
                self?.webView.load(urlRequest)
            }
        }).disposed(by: disposeBag)
    }
    private func setText(text: String) {
        textLabel.text = text
        if searchUberEatsApi.isOn {
                self.viewModel.loadUberEats(text: text)
        }
    }
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print("start")
            recordButton.isSelected = true
            recordButton.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.1254901961, blue: 0.1294117647, alpha: 1)
            viewModel.startSpeechRecognition()
        }  else if sender.state == .ended || sender.state == .cancelled {
            print("FINISHED UP LONG PRESS")
            viewModel.stopSpeachRecognition()
            recordButton.backgroundColor = #colorLiteral(red: 0.8544178299, green: 0.5002352072, blue: 0.006223022287, alpha: 1)
            recordButton.isSelected = false
        }
        
    }
}

extension SpeechRecognizerViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        getHtml()
    }
    func getHtml() {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
                                    if let content = html as? String {
                                        self.viewModel.getResturantFrom(html: content)
                                    }
        }) }
    
    private func handleResturants(restrantsNames: [String]) {
        resturants = restrantsNames
        ResturantTableView.reloadData()
    }
}
extension SpeechRecognizerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell")!
        cell.textLabel?.text = resturants[indexPath.row]
        return cell
    }
}


extension UIButton {
    @IBInspectable var cornerRaduis: CGFloat  {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}








import Foundation
import CoreLocation


class LocationManager: NSObject {
    
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}


// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        guard let location = manager.location else {
            return
        }
        getPlace(for: location, completion: {
            place in
            print(place?.areasOfInterest)
        })
    }
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
    
        case .notDetermined         : print("notDetermined")        // location permission not asked for yet
        case .authorizedWhenInUse   : print("authorizedWhenInUse")  // location authorized
        case .authorizedAlways      : print("authorizedAlways")     // location authorized
        case .restricted            : print("restricted")           // TODO: handle
        case .denied                : print("denied")               // TODO: handle
        }
    }
}



extension LocationManager {
    
    public var exposedLocation: CLLocation? {
           return self.locationManager.location
       }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
