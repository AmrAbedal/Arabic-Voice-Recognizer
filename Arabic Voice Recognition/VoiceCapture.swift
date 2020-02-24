//
//  VoiceCapture.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import AVFoundation

protocol VoiceCapture {
    func startCapture(completion: @escaping (AVAudioPCMBuffer)->()) throws
    func stop()
    
}
class AVFoundationVoiceCapture: VoiceCapture {
    private let audioEngine = AVAudioEngine()
    
    func startCapture(completion: @escaping (AVAudioPCMBuffer)->()) throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            completion(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func stop() {
        
    }
    
    
}
