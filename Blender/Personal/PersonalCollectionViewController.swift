//
//  PersonalCollectionViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class PersonalCollectionViewController: UITableViewController {

    var collections = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collections = ["", "", "", "", "", "", "", "", "", ""]
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var refreshAlert = UIAlertController(title: "刪除收藏", message: "確定要刪除此筆收藏？", preferredStyle: UIAlertControllerStyle.Alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in

                self.collections.removeAtIndex(indexPath.row)
                tableView.reloadData()

            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            }))

            presentViewController(refreshAlert, animated: true, completion: nil)
        }
    }

}
