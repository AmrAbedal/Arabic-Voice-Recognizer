//
//  SpeachRecognizer.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import Speech

protocol SpeachRecognizer {
    
}

class DefaultSpeachRecognizer: SpeachRecognizer {
  private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier:  "ar_SA"))!
    
    func startRecognize(textCompletion:@escaping (String)->()) {
       let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                      recognitionRequest.shouldReportPartialResults = true
                      if #available(iOS 13, *) {
                          recognitionRequest.requiresOnDeviceRecognition = false
                      }
    speechRecognizer.recognitionTask(with: recognitionRequest) {  result, error in
                     var isFinal = false
                     
                     if let result = result {
                         // Update the text view with the results.
                         print(result.bestTranscription.formattedString)
                         textCompletion(result.bestTranscription.formattedString)
                         isFinal = result.isFinal
                         print("Text \(result.bestTranscription.formattedString)")
                     }
                     
                     if error != nil || isFinal {
                        
                        
                     }
                 }

    }
    
}
