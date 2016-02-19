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
    recordTableView.rowHeight = UITableViewAutomaticDimension
    recordTableView.estimatedRowHeight = 100
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
      let formatter = NSDateFormatter()
      formatter.dateStyle = .MediumStyle
      formatter.timeStyle = .MediumStyle

      let dateString = formatter.stringFromDate(record.date.toNSDate())
      recipeTitle.text = record.title
      madeDate.text = dateString
    }
  }
}

class Record: NSObject, NSCoding {
  var title: String!
  var date: String!

  init(title: String, date: String) {
    self.title = title
    self.date = date
  }

  required convenience init(coder aDecoder: NSCoder) {
    let title = aDecoder.decodeObjectForKey("title") as! String
    let date = aDecoder.decodeObjectForKey("date") as! String
    self.init(title: title, date: date)
  }

  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(title, forKey: "title")
    aCoder.encodeObject(date, forKey: "date")
  }
}


