//
//  OperationSetting.swift
//  Blender
//
//  Created by Bryan Lin on 9/6/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class OperationSetting: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let TAG_TIME = 0
    let TAG_SPEED = 1

    var curTime = 1
    var curSpeed = 1

    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timerPicker: UIView!
    @IBOutlet weak var speedPicker: UIView!
    @IBOutlet weak var blockingView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!

    @IBAction func stopBlender(sender: UIButton) {
        checkBlenderConnection()
        BlenderBluetoothManager.sharedLoader.stopBlending()
    }

    @IBAction func startBlender(sender: UIButton) {
        checkBlenderConnection()
        BlenderBluetoothManager.sharedLoader.startBlending(curTime, speed: curSpeed)
    }

    func checkBlenderConnection() {
        if (!BlenderBluetoothManager.sharedLoader.connected) {
            let alert = UIAlertController(title: "未連接果汁機", message: "請先至連線設定頁面連接果汁機", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func openTimePicker(sender: UIButton) {
        showTimePicker()
    }

    func showTimePicker() {
        blockingView.hidden = false
        timerPicker.hidden = false
    }

    @IBAction func openSpeedPicker(sender: UIButton) {
        showSpeedPicker()
    }

    func showSpeedPicker() {
        blockingView.hidden = false
        speedPicker.hidden = false
    }

    @IBAction func onTimePickComplete(sender: UIButton) {
        hideTimePicker()
        timeLabel.text = String(curTime)
    }

    @IBAction func onTimePickCancel(sender: UIButton) {
        hideTimePicker()
    }

    @IBAction func onSpeedPickComplete(sender: UIButton) {
        hideSpeedPicker()
        speedLabel.text = String(curSpeed)
    }

    @IBAction func onSpeedPickCancel(sender: UIButton) {
        hideSpeedPicker()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCornerRadius()
        hideTimePicker()
        hideSpeedPicker()
    }

    func hideTimePicker() {
        blockingView.hidden = true
        timerPicker.hidden = true
    }

    func hideSpeedPicker() {
        blockingView.hidden = true
        speedPicker.hidden = true
    }

    func setupCornerRadius() {
        stopBtn.layer.cornerRadius = 3.5
        stopBtn.layer.masksToBounds = true

        startBtn.layer.cornerRadius = 3.5
        startBtn.layer.masksToBounds = true
    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == TAG_TIME {
            return 60

        } else if pickerView.tag == TAG_SPEED {
            return 5
        }
        return 0
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let attrString = NSAttributedString(string: String(row + 1), attributes: [NSForegroundColorAttributeName:
            UIColor(rgba: "#336900")])
        return attrString
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == TAG_TIME {
            curTime = row + 1

        } else if pickerView.tag == TAG_SPEED {
            curSpeed = row + 1
        }
    }

}
