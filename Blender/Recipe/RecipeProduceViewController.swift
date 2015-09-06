//
//  RecipeProduceViewController.swift
//  Blender
//
//  Created by Bryan Lin on 9/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeProduceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var startBlendingBtn: UIButton!
    @IBOutlet weak var skipBlendingBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!

    let demoSteps = [
        "雪梨洗淨去皮，切成可放入榨汁機內 雪梨洗淨去皮，切成可放入榨汁機內",
        "香蕉去皮切成數段",
        "啟動果汁機，轉速2，10秒。",
        "檸檬連皮對切為四份去核",
        "將所有材料順序放入榨汁機內壓榨成汁榨成汁",
        "啟動果汁機，轉速3，7秒。"
    ]

    let demoSpeeds = [
        0,
        0,
        2,
        0,
        0,
        3
    ]

    let demoTimes = [
        0,
        0,
        10,
        0,
        0,
        7
    ]

    var demoCheckState = [
        false,
        false,
        false,
        false,
        false,
        false
    ]

    @IBOutlet weak var recipeSteps: UITableView!

    var currentStep: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCornerRadius()
        updateExcuteButton()
    }

    @IBAction func onCompleteBtnTouchUp(sender: UIButton) {
        println("Complete")
        restartRecipe()
    }

    @IBAction func onConfirmBtnTouchUp(sender: UIButton) {
        println("Confirm")
        completeStep()
    }

    @IBAction func onStartBlendingBtnTouchUp(sender: UIButton) {
        println("StartBlending")
        completeStep()
    }

    @IBAction func onSkipBlendingBtnTouchUp(sender: UIButton) {
        println("SkipBlending")
        completeStep()
    }

    func restartRecipe() {
        currentStep = 0

        demoCheckState = [
            false,
            false,
            false,
            false,
            false,
            false
        ]

        updateExcuteButton()
        recipeSteps.reloadData()
    }

    func completeStep() {
        demoCheckState[currentStep] = true
        currentStep++
        updateExcuteButton()
        recipeSteps.reloadData()
    }

    func updateExcuteButton() {
        startBlendingBtn.hidden = true
        skipBlendingBtn.hidden = true
        confirmBtn.hidden = true
        completeBtn.hidden = true

        if currentStep == demoSteps.count {
            completeBtn.hidden = false
            return
        }

        let stepTime = demoTimes[currentStep]
        if (stepTime > 0) {
            startBlendingBtn.hidden = false
            skipBlendingBtn.hidden = false

        } else {
            confirmBtn.hidden = false
        }
    }

    func setupCornerRadius() {
        startBlendingBtn.layer.cornerRadius = 3.5
        startBlendingBtn.layer.masksToBounds = true

        skipBlendingBtn.layer.cornerRadius = 3.5
        skipBlendingBtn.layer.masksToBounds = true

        confirmBtn.layer.cornerRadius = 3.5
        confirmBtn.layer.masksToBounds = true

        completeBtn.layer.cornerRadius = 3.5
        completeBtn.layer.masksToBounds = true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoSteps.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeStepCell", forIndexPath: indexPath) as! RecipeProduceTableViewCell

        cell.stepNumber.text = String(indexPath.row + 1)
        cell.stepContent.text = demoSteps[indexPath.row]
        dispatch_async(dispatch_get_main_queue(), {() in
            cell.stepContent.numberOfLines = 2
            cell.stepContent.sizeToFit()
        })

        cell.stepCheckIcon.hidden = !demoCheckState[indexPath.row]
        return cell
    }

}
