//
//  PersonalRecordViewController.swift
//  Blender
//
//  Created by Bryan Lin on 2/19/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import UIKit

class PersonalRecordViewController: UIViewController {
  @IBOutlet weak var recordTableView: UITableView!

  var records = [Record]()

  override func viewDidLoad() {
    super.viewDidLoad()

    records = RecipeManager.sharedInstance.loadRecords()
  }
}

extension PersonalRecordViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return records.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recordCell", forIndexPath: indexPath) as! RecordCell

    cell.record = records[indexPath.row]
    return cell
  }
}

class RecordCell: UITableViewCell {
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var madeDate: UILabel!

  var record: Record! {
    didSet {
      recipeTitle.text = record.title
      madeDate.text = record.date
    }
  }
}


struct Record {
  var title = ""
  var date = ""
}