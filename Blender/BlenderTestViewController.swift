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
//    var deivces = [String]()
//
//    @IBAction func onSwitchValueChanged(sender: UISwitch) {
//        updateLayout(sender.on);
//    }
//
//    func updateLayout(startMatching: Bool) {
//        remindingText.hidden = startMatching
//        devicesText.hidden = !startMatching
//        devicesArea.hidden = !startMatching
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        updateLayout(false);
//
//        deivces.append("Fake 1")
//        deivces.append("Fake 2")

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

//    // MARK: - TableView dataSource
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return deivces.count
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("blenderDeviceCell", forIndexPath: indexPath) as! UITableViewCell
//
//        return cell
//    }


//    // MARK: - Table view data source
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recipes.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) as! UITableViewCell
//
//        // Configure the cell...
//
//        return cell
//    }



}
