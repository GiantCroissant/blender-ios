//
//  PersonalViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var personalCollectionView: UIView!
    @IBOutlet weak var personalProfileView: UIView!
    
    @IBAction func segmentValueChanged(sender: AYOSegmentedControl) {
        switch (sender.selectedIndex) {
        case 0:
            personalProfileView.hidden = false
            personalCollectionView.hidden = true
            break
        case 1:
            personalProfileView.hidden = true
            personalCollectionView.hidden = false
            break
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
