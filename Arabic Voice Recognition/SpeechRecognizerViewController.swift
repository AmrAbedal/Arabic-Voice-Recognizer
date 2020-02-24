//
//  SpeechRecognizerViewController.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit
import RxSwift

class SpeechRecognizerViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var searchUberEatsApi: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSubscribers()
    }
    private func setSubscribers() {
        viewModel.textChangeSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let text = elemnt {
                self?.setText(text: text)
            }
        }).disposed(by: disposeBag)
    }
    private func setText(text: String) {
        textLabel.text = text
    }
    
    @IBAction func startRecordButtonTapped(_ sender: UIButton) {
        if searchUberEatsApi.isOn {
            
        } else {
            viewModel.startSpeechRecognition()
        }
    }
    
    
    
}
