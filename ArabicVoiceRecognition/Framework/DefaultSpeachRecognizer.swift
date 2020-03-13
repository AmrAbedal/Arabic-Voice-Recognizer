//
//  DefaultSpeachRecognizer.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import Speech

class DefaultSpeachRecognizer: SpeachRecognizer {
    private  var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer: SFSpeechRecognizer
    private let voiceCapture: VoiceCapture
    init(voiceCapture: VoiceCapture,speechRecognizer: SFSpeechRecognizer = SFSpeechRecognizer(locale: Locale(identifier:  "ar_SA"))!)  {
        self.voiceCapture = voiceCapture
        self.speechRecognizer = speechRecognizer
    }
    private func setupVoiceCapture() throws {
        try voiceCapture.startCapture(completion: {
            buffer in
            self.recognitionRequest?.append(buffer)
        })
    }
    func startRecognize(textCompletion:@escaping (String)->()) throws  {
        try setupVoiceCapture()
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        speechRecognizer.recognitionTask(with: recognitionRequest) {  result, error in
            var isFinal = false
            
            if let result = result, result.isFinal {
                // Update the text view with the results.
                print(result.bestTranscription.formattedString)
                textCompletion(result.bestTranscription.formattedString)
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                self.stop()
            }
        }
        try voiceCapture.start()
    }
    func stop() {
        voiceCapture.stop()
        recognitionRequest?.endAudio()
        recognitionRequest = nil
    }
    
}
