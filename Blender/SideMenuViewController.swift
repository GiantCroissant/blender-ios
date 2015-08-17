//
//  SideMenuViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

//    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.blackColor()
//        return indexPath
//    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.blackColor()
    }

    // if tableView is set in attribute inspector with selection to multiple Selection it should work.

    // Just set it back in deselect

//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        var cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//        cellToDeSelect.contentView.backgroundColor = UIColor.blackColor()
//    }

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        var cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.blackColor()
    }

}
