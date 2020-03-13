//
//  VoiceRecognitionViewModel.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import SwiftSoup


class VoiceRecognitionViewModel {
    private let disposBag = DisposeBag()
    let textChangeSubject = BehaviorSubject<String?>(value: nil)
    let resturantListSubject = BehaviorSubject<[Resturant]?>(value: nil)
    typealias loadLocationUseCaseType = (LoadLocatinostDataSource , String) -> Single<[LocatinoScreenData]>
    let loadLocationUseCase: loadLocationUseCaseType
    let loadLocationDataSource: LoadLocatinostDataSource
    typealias loadResturantsType = (LoadResturantDataSource, String, String) -> Single <[Resturant]>
    let loadResturantsDataSource: LoadResturantDataSource
    let loadResturantsUsecase: loadResturantsType
    let areaCapture: AreaNameCapture
    let speexhRecognizer: SpeachRecognizer
    
    init(speexhRecognizer: SpeachRecognizer = DefaultSpeachRecognizer(voiceCapture: AVFoundationVoiceCapture()),
         areaCapture: AreaNameCapture = AppleAreaNameCapture(locationCapture: AppleCoreLocationCapture()),
         loadResturantsDataSource: LoadResturantDataSource = MoyaLoadResturantDataSource(),
         loadResturantsUsecase: @escaping loadResturantsType = loadResturantsUseCase,
         loadLocationDataSource: LoadLocatinostDataSource = MoyaLoadLocationDataSource(),
         loadLocationUseCase: @escaping loadLocationUseCaseType = loadLocationUseCae ) {
        self.speexhRecognizer = speexhRecognizer
        self.areaCapture = areaCapture
        self.loadResturantsDataSource = loadResturantsDataSource
        self.loadResturantsUsecase = loadResturantsUsecase
        self.loadLocationUseCase = loadLocationUseCase
        self.loadLocationDataSource = loadLocationDataSource
    }
    
    func startSpeechRecognition() {
        do { try speexhRecognizer.startRecognize(textCompletion: { [weak self] text in
            print(text)
            self?.textChangeSubject.onNext(text)
        }) } catch {
            print(error)
        }
    }
    func stopSpeachRecognition() {
        speexhRecognizer.stop()
    }
    
    func fetchResturantsWith(searchText: String) {
        areaCapture.getAreaName( onlyOne: true, completion: {
            areaName in
            self.loadLocations(area: areaName ,text : searchText)
        })
    }
    private func loadLocations(area: String,text: String) {
        loadLocationUseCase(loadLocationDataSource,area).subscribe(onSuccess: {
            result in
            print(result)
            self.handleLocations(locations: result, text: text)
        }, onError: {
            error in
            print(error)
        }).disposed(by: disposBag)
    }
    
    private func handleLocations(locations: [LocatinoScreenData],text: String) {
        if let areaName = locations.first?.addressLine2 {
            loadResturant(area: areaName, text: text)
        }
    }
    
    private func loadResturant(area: String,text: String) {
        loadResturantsUsecase(loadResturantsDataSource,area,text).subscribe(onSuccess: {
            result in
            print(result)
            self.resturantListSubject.onNext(result)
        }, onError: {
            error in
            print(error)
        }).disposed(by: disposBag)
    }
}

