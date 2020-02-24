//
//  SpeechRecognizerViewController.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit

class SpeechRecognizerViewController: UIViewController {
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startRecordButtonTapped(_ sender: UIButton) {
        viewModel.startSpeechRecognition()
    }
    


}
