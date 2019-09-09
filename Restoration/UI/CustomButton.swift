//
//  CustomButton.swift
//  UIStoryboard
//
//  Created by Антон Семенец on 01/09/2019.
//  Copyright © 2019 Anton Semenets. All rights reserved.
//

import UIKit

@IBDesignable class ColorButton: UIButton {
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable var tntColor: UIColor? {
        didSet {
            self.tintColor = tntColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
