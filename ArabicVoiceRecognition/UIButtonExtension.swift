//
//  UIButtonExtension.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 2/27/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var cornerRaduis: CGFloat  {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}
