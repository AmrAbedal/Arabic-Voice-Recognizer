    //
    //  AVFoundationVoiceCapture.swift
    //  Arabic Voice Recognition
    //
    //  Created by Amr AbdelWahab on 2/24/20.
    //  Copyright © 2020 Orcas. All rights reserved.
    //
    
    import Foundation
    import AVFoundation
    
    class AVFoundationVoiceCapture: VoiceCapture {
        private let audioEngine:AVAudioEngine
        var inputNode: AVAudioInputNode
        init(audioEngine:AVAudioEngine = AVAudioEngine()) {
            self.audioEngine = audioEngine
            inputNode = audioEngine.inputNode
        }
        
        func start() throws {
            audioEngine.prepare()
            try audioEngine.start()
        }
        
        func startCapture(completion: @escaping (AVAudioPCMBuffer)->()) throws {
            guard !audioEngine.isRunning else { return }
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                completion(buffer)
            }
        }
        
        func stop() {
            self.audioEngine.stop()
            inputNode.removeTap(onBus: 0)
        }
    }
