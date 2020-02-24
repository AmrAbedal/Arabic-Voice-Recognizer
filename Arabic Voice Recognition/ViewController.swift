//
//  ViewController.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController {
    private lazy var viewModel = { return VoiceRecognitionViewModel() }()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier:  "ar_SA"))!
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    @IBOutlet weak var startOrStopButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func startOrStopRecordButtonTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
        } else {
            startRecording()
        }
    }
    private func startRecording() {
        do {  let audioSession = AVAudioSession.sharedInstance()
              try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
              try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
              let inputNode = audioEngine.inputNode
            
            
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
                recognitionRequest.shouldReportPartialResults = true
                
                // Keep speech recognition data on device
                if #available(iOS 13, *) {
                    recognitionRequest.requiresOnDeviceRecognition = false
                }
            
            
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                  var isFinal = false
                  
                  if let result = result {
                      // Update the text view with the results.
                      print(result.bestTranscription.formattedString)
                      isFinal = result.isFinal
                      print("Text \(result.bestTranscription.formattedString)")
                  }
                  
                  if error != nil || isFinal {
                      // Stop recognizing speech if there is a problem.
                      self.audioEngine.stop()
                      inputNode.removeTap(onBus: 0)

                      self.recognitionRequest = nil
                      self.recognitionTask = nil
                  }
              }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
                  inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                      self.recognitionRequest?.append(buffer)
                  }
                  
                  audioEngine.prepare()
                  try audioEngine.start()
        } catch {
            print(error)
        }
    }
    
    

}

