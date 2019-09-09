//
//  ComponentView.swift
//  UIStoryboard
//
//  Created by Антон Семенец on 01/09/2019.
//  Copyright © 2019 Anton Semenets. All rights reserved.
//

import UIKit

@IBDesignable class ComponentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        if let nib = Bundle.main.loadNibNamed("ComponentView",
                                              owner: nil,
                                              options: nil),
            let view = nib[0] as? UIView {
            addSubview(view)
        }
    }
    
}
