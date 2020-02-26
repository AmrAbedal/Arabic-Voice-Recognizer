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
    func startRecognize(textCompletion:@escaping (String)->()) throws
    func stop()
}
