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
    let textChangeSubject = BehaviorSubject<String?>(value: nil)
    let resturantListSubject = BehaviorSubject<[String]?>(value: nil)

    let speexhRecognizer: SpeachRecognizer
    init(speexhRecognizer: SpeachRecognizer = DefaultSpeachRecognizer(voiceCapture: AVFoundationVoiceCapture())
    ) {
        self.speexhRecognizer = speexhRecognizer
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
    func search() {
        
    }
    func getResturantFrom(html: String) {
           do {
               let html: String = html;
               let doc: Document = try SwiftSoup.parse(html)
               let link: Elements = try doc.getElementsByClass("ap aq ar as dl bf be bd")
               print(link.array().map({ try? $0.text()}))
               if let resturants = link.array().map({ try? $0.text()}) as? [String] {
                resturantListSubject.onNext(resturants)
               }
              
           } catch Exception.Error(let type, let message) {
               print(message)
           } catch {
               print("error")
           }
           
       }
}
