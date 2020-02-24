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
