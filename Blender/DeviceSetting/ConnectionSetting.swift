//
//  ConnectionSetting.swift
//  Blender
//
//  Created by Bryan Lin on 9/6/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class ConnectionSetting: UIViewController, UITableViewDataSource {

    @IBOutlet weak var remindingText: UILabel!
    @IBOutlet weak var devicesText: UILabel!
    @IBOutlet weak var devicesArea: UIView!

    @IBAction func onSwitchValueChanged(sender: UISwitch) {
        updateLayout(sender.on);
    }

    func updateLayout(startMatching: Bool) {
        remindingText.hidden = startMatching
        devicesText.hidden = !startMatching
        devicesArea.hidden = !startMatching
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blenderDeviceCell", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLayout(false)
    }

}
