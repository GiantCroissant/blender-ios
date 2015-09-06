//
//  OperationSetting.swift
//  Blender
//
//  Created by Bryan Lin on 9/6/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class OperationSetting: UIViewController {

    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


        stopBtn.layer.cornerRadius = 3.5
        stopBtn.layer.masksToBounds = true

        startBtn.layer.cornerRadius = 3.5
        startBtn.layer.masksToBounds = true


    }

}
