//
//  RecipeDetailsViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var stepsView: UIView!

    @IBAction func segmentValueChanged(sender: AYOSegmentedControl) {

        switch (sender.selectedIndex) {
        case 0:
            infoView.hidden = false
            videoView.hidden = true
            stepsView.hidden = true
            break

        case 1:
            infoView.hidden = true
            videoView.hidden = false
            stepsView.hidden = true
            break

        case 2:
            infoView.hidden = true
            videoView.hidden = true
            stepsView.hidden = false
            break

        default:
            break
        }
    }

}
