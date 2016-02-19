//
//  RecipeProduceViewController.swift
//  Blender
//
//  Created by Bryan Lin on 9/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeProduceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BlenderConnectionState {

  @IBOutlet weak var startBlendingBtn: UIButton!
  @IBOutlet weak var skipBlendingBtn: UIButton!
  @IBOutlet weak var confirmBtn: UIButton!
  @IBOutlet weak var completeBtn: UIButton!
  @IBOutlet weak var connectBlenderSettingBtn: UIButton!
  @IBOutlet weak var connectionStatusLabel: UILabel!
  @IBOutlet weak var recipeSteps: UITableView!
  @IBOutlet weak var recipeTitle: UILabel!

  var recipe: Recipe!
//
//  let demoSteps = [
//    "雪梨洗淨去皮，切成可放入榨汁機內 雪梨洗淨去皮，切成可放入榨汁機內",
//    "香蕉去皮切成數段",
//    "啟動果汁機，轉速2，10秒。",
//    "檸檬連皮對切為四份去核",
//    "將所有材料順序放入榨汁機內壓榨成汁榨成汁",
//    "啟動果汁機，轉速3，7秒。"
//  ]
//
//  let demoSpeeds = [
//    0,
//    0,
//    1, // 2
//    0,
//    0,
//    1  // 3
//  ]
//
//  let demoTimes = [
//    0,
//    0,
//    10,
//    0,
//    0,
//    7
//  ]
//
//  var demoCheckState = [
//    false,
//    false,
//    false,
//    false,
//    false,
//    false
//  ]

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

//    // not connected
//    if !BlenderBluetoothManager.sharedLoader.connected {
//      connectBlenderSettingBtn.hidden = false
//      return
//    }

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
    startBlendingBtn.rounded(3.5)
    skipBlendingBtn.rounded(3.5)
    confirmBtn.rounded(3.5)
    completeBtn.rounded(3.5)
    connectBlenderSettingBtn.rounded(3.5)
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipe.steps.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recipeStepCell", forIndexPath: indexPath) as! RecipeProduceTableViewCell

    cell.stepNumber.text = String(indexPath.row + 1)
    cell.stepContent.text = recipe.steps[indexPath.row].action
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
  func rounded(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
}