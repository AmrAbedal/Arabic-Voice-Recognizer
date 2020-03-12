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

    typealias loadResturantsType = (LoadResturantDataSource, String, String) -> Single <[Resturant]>
    let loadResturantsDataSource: LoadResturantDataSource
    let loadResturantsUsecase: loadResturantsType
    let areaCapture: AreaNameCapture
    let speexhRecognizer: SpeachRecognizer
    init(speexhRecognizer: SpeachRecognizer = DefaultSpeachRecognizer(voiceCapture: AVFoundationVoiceCapture()),
        areaCapture: AreaNameCapture = AppleAreaNameCapture(locationCapture: AppleCoreLocationCapture()),
        loadResturantsDataSource: LoadResturantDataSource = MoyaLoadResturantDataSource(),
        loadResturantsUsecase: @escaping loadResturantsType = loadResturantsUseCase
    
    ) {
        self.speexhRecognizer = speexhRecognizer
        self.areaCapture = areaCapture
        self.loadResturantsDataSource = loadResturantsDataSource
        self.loadResturantsUsecase = loadResturantsUsecase
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
  
    func loadResturantsWithUberEats(text: String) {
        areaCapture.getAreaName( onlyOne: true, completion: {
            areaName in
                self.loadResturant(area: areaName ,text : text)
        })
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
