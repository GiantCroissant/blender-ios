//
//  BlenderTestViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class BlenderTestViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
