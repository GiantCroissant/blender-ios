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
  @IBOutlet weak var remindingText: UILabel!
  @IBOutlet weak var devicesText: UILabel!
  @IBOutlet weak var devicesArea: UIView!
  @IBOutlet weak var operationSettingPage: UIView!
  @IBOutlet weak var connectionSettingPage: UIView!

  @IBAction func onSegmentedValueChanged(sender: AYOSegmentedControl) {
    switch (sender.selectedIndex) {
    case 0:
      connectionSettingPage.hidden = false
      operationSettingPage.hidden = true
      break

    case 1:
      connectionSettingPage.hidden = true
      operationSettingPage.hidden = false
      break

    default:
      break
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = "revealToggle:"
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
  }
}
