//
//  VoiceRecognitionViewModel.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift

class VoiceRecognitionViewModel {
    let textChangeSubject = BehaviorSubject<String?>(value: nil)
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
        let url = URL(string: "https://www.ubereats.com/en-EG/search?pl=JTdCJTIyYWRkcmVzcyUyMiUzQSUyMktvc2hhcnklMjBFbCUyMFRhaHJpciUyMiUyQyUyMnJlZmVyZW5jZSUyMiUzQSUyMkNoSUp4eXJEWkdzLVdCUVJocEVaREpmVjVQMCUyMiUyQyUyMnJlZmVyZW5jZVR5cGUlMjIlM0ElMjJnb29nbGVfcGxhY2VzJTIyJTJDJTIybGF0aXR1ZGUlMjIlM0EzMC4wNjY5NzU2JTJDJTIybG9uZ2l0dWRlJTIyJTNBMzEuMzM2NDI3Njk5OTk5OTk4JTdE&q=Fast%20Food")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error)")
                return
            }

            let string = String(data: data, encoding: .utf8)

            print("\(string)")
        }

        task.resume()
    }
    
}
