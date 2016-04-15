//
//  CompanyInfoViewController.swift
//  Blender
//
//  Created by Bryan Lin on 11/18/15.
//  Copyright © 2015 GiantCroissant. All rights reserved.
//

import UIKit

class CompanyInfoViewController: UIViewController {
  @IBOutlet weak var menuButton: UIBarButtonItem!
  @IBOutlet weak var companyVC: UIView!
  @IBOutlet weak var productVC: UIView!
  
  @IBAction func onValueChange(sender: AYOSegmentedControl) {
    switch (sender.selectedIndex) {
    case 0:
      companyVC.showSelf()
      productVC.hideSelf()
      break
    case 1:
      companyVC.hideSelf()
      productVC.showSelf()
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

extension UIView {
  func showSelf() {
    self.hidden = false
  }

  func hideSelf() {
    self.hidden = true
  }
}