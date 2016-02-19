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
    recordTableView.rowHeight = UITableViewAutomaticDimension
    recordTableView.estimatedRowHeight = 100
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    records = RecipeManager.sharedInstance.loadRecords()
    recordTableView.reloadData()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detail" {
      let cell = sender as! RecordCell
      let vc = segue.destinationViewController as! RecipeDetailsViewController
      vc.recipe = RecipeManager.sharedInstance.getRecipe(cell.record.recipeId)
    }
  }

}

extension PersonalRecordViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return records.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("recordCell", forIndexPath: indexPath) as! RecordCell
    cell.record = records[indexPath.row]

    let bgColor = indexPath.row % 2 == 0 ? UIColor(rgba: "#fafafa") : UIColor.whiteColor()
    cell.cellBackgroundView.backgroundColor = bgColor
    return cell
  }
}

class RecordCell: UITableViewCell {
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var madeDate: UILabel!
  @IBOutlet weak var cellBackgroundView: UIView!

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
  var recipeId: String!
  var title: String!
  var date: String!

  init(recipeId: String, title: String, date: String) {
    self.recipeId = recipeId
    self.title = title
    self.date = date
  }

  required convenience init?(coder aDecoder: NSCoder) {
    let recipeId = aDecoder.decodeObjectForKey("recipeId") as! String
    let title = aDecoder.decodeObjectForKey("title") as! String
    let date = aDecoder.decodeObjectForKey("date") as! String
    self.init(recipeId: recipeId, title: title, date: date)
  }

  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(recipeId, forKey: "recipeId")
    aCoder.encodeObject(title, forKey: "title")
    aCoder.encodeObject(date, forKey: "date")
  }
}


