//
//  ViewControllerC.swift
//  Restoration
//
//  Created by Антон Семенец on 09/09/2019.
//  Copyright © 2019 Anton Semenets. All rights reserved.
//

import UIKit

class ViewControllerC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }

}
