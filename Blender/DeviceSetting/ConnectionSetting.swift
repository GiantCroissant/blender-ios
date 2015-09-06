//
//  ConnectionSetting.swift
//  Blender
//
//  Created by Bryan Lin on 9/6/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit
import CoreBluetooth

class ConnectionSetting: UIViewController, UITableViewDataSource, UITableViewDelegate, BlenderBluetoothProtocal {

    @IBOutlet weak var remindingText: UILabel!
    @IBOutlet weak var devicesText: UILabel!
    @IBOutlet weak var devicesArea: UIView!
    @IBOutlet weak var deviceList: UITableView!

    @IBAction func onSwitchValueChanged(sender: UISwitch) {
        updateLayout(sender.on);

        if sender.on {
            BlenderBluetoothManager.sharedLoader.scanBLEDevices()

        } else {
            BlenderBluetoothManager.sharedLoader.stopScanBLEDevices()
        }
    }

    func didDiscoveredDevice() {
        deviceList.reloadData()
    }

    func didConnectedDevice() {
        deviceList.reloadData()
    }

    func updateLayout(startMatching: Bool) {
        remindingText.hidden = startMatching
        devicesText.hidden = !startMatching
        devicesArea.hidden = !startMatching
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BlenderBluetoothManager.sharedLoader.devices.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blenderDeviceCell", forIndexPath: indexPath) as! BLEDeviceTableViewCell

        let device = BlenderBluetoothManager.sharedLoader.devices[indexPath.row]
        cell.deviceName.text = device.name

        if (device.state == .Connected) {
            cell.statusLabel.text = "已連結"
            cell.disconnectedIcon.hidden = true

        } else if (device.state == CBPeripheralState.Disconnected) {
            cell.statusLabel.text = "未連結"
            cell.disconnectedIcon.hidden = false

        } else if (device.state == CBPeripheralState.Connecting) {
            cell.statusLabel.text = "連結中"
            cell.disconnectedIcon.hidden = false
        }

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        BlenderBluetoothManager.sharedLoader.delegate = self
        updateLayout(false)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let device = BlenderBluetoothManager.sharedLoader.devices[indexPath.row]
        BlenderBluetoothManager.sharedLoader.connectDevice(device)
    }

}
