//
//  RecipeProduceViewController.swift
//  Blender
//
//  Created by Bryan Lin on 9/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeProduceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BlenderConnectionState {

  let DEBUG_MODE = true

  @IBOutlet weak var startBlendingBtn: UIButton!
  @IBOutlet weak var skipBlendingBtn: UIButton!
  @IBOutlet weak var confirmBtn: UIButton!
  @IBOutlet weak var completeBtn: UIButton!
  @IBOutlet weak var connectBlenderSettingBtn: UIButton!
  @IBOutlet weak var connectionStatusLabel: UILabel!
  @IBOutlet weak var recipeSteps: UITableView!
  @IBOutlet weak var recipeTitle: UILabel!

  var recipe: Recipe!

  var blendSpeeds = [Int]()
  var blendTimes = [Int]()
  var checkStates = [Bool]()
  var currentStep: Int = 0
  var totalStepCount: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    BlenderBluetoothManager.sharedLoader.connectionDelegate = self
    didUpdateState()
    setupCornerRadius()
    configureTableView()

    recipeTitle.text = recipe.title
    recipe.steps.forEach { step in
      blendSpeeds.append(step.machineAction?.speed ?? 0)
      blendTimes.append(step.machineAction?.time ?? 0)
      checkStates.append(false)
      totalStepCount++
    }
    updateExcuteButton()
  }

  func configureTableView() {
    recipeSteps.rowHeight = UITableViewAutomaticDimension
    recipeSteps.estimatedRowHeight = 160.0
    recipeSteps.separatorInset = UIEdgeInsetsZero
  }

  func didUpdateState() {
    if (BlenderBluetoothManager.sharedLoader.connected) {
      connectionStatusLabel.text = "已連結"

    } else {
      connectionStatusLabel.text = "未連結"
    }
  }

  @IBAction func onCompleteBtnTouchUp(sender: UIButton) {
    print("Complete")
    restartRecipe()
    RecipeManager.sharedInstance.saveRecord(recipe)
  }

  @IBAction func onConfirmBtnTouchUp(sender: UIButton) {
    print("Confirm")
    completeStep()
  }

  @IBAction func onStartBlendingBtnTouchUp(sender: UIButton) {
    let time = blendTimes[currentStep]
    let speed = blendSpeeds[currentStep]
    BlenderBluetoothManager.sharedLoader.startBlending(time, speed: speed)
    print("StartBlending -> time[ \(time) ] speed[ \(speed) ]")
    completeStep()
  }

  @IBAction func onSkipBlendingBtnTouchUp(sender: UIButton) {
    print("SkipBlending")
    completeStep()
  }

  func restartRecipe() {
    currentStep = 0
    checkStates = checkStates.flatMap { _ in false }
    updateExcuteButton()
    recipeSteps.reloadData()
  }

  func completeStep() {
    checkStates[currentStep] = true
    currentStep++
    updateExcuteButton()
    recipeSteps.reloadData()
  }

  func updateExcuteButton() {
    connectBlenderSettingBtn.hidden = true
    startBlendingBtn.hidden = true
    skipBlendingBtn.hidden = true
    confirmBtn.hidden = true
    completeBtn.hidden = true

    // not connected
    if !DEBUG_MODE {
      if !BlenderBluetoothManager.sharedLoader.connected {
        connectBlenderSettingBtn.hidden = false
        return
      }
    }

    if currentStep == totalStepCount {
      completeBtn.hidden = false
      return
    }

    let stepTime = blendTimes[currentStep]
    if (stepTime > 0) {
      startBlendingBtn.hidden = false
      skipBlendingBtn.hidden = false

    } else {
      confirmBtn.hidden = false
    }
  }

  func setupCornerRadius() {
    startBlendingBtn.rounded()
    skipBlendingBtn.rounded()
    confirmBtn.rounded()
    completeBtn.rounded()
    connectBlenderSettingBtn.rounded()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipe.steps.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recipeStepCell", forIndexPath: indexPath) as! RecipeProduceTableViewCell

    let step = recipe.steps[indexPath.row]
    var machineStep = ""
    if let speed = step.machineAction?.speed, let time = step.machineAction?.time {
      machineStep = " - 轉速 \(speed), \(time) 秒"
    }
    cell.stepNumber.text = String(indexPath.row + 1)
    cell.stepContent.text = step.action + machineStep
    cell.stepCheckIcon.hidden = !checkStates[indexPath.row]
    return cell
  }

}

class RecipeProduceTableViewCell: UITableViewCell {
  @IBOutlet weak var stepNumber: UILabel!
  @IBOutlet weak var stepContent: UILabel!
  @IBOutlet weak var stepCheckIcon: UIImageView!
}

extension UIButton {
  func rounded(radius: CGFloat = 2.0) {
    self.layer.cornerRadius = radius
  }
}