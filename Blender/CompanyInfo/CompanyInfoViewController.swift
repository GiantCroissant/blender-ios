//
//  CompanyInfoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 11/18/15.
//  Copyright © 2015 GiantCroissant. All rights reserved.
//

import UIKit

class CompanyInfoViewController: UIViewController
{
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
