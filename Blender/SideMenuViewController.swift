//
//  SideMenuViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    private var customBackground: UIView!
    private let cellSelectedColor = UIColor.blackColor()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (cell.selected) {
//            cell.backgroundColor = cellSelectedColor
//
//        } else {
//            cell.backgroundColor = tableView.backgroundColor
//        }
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! UITableViewCell
//        cell.selectedBackgroundView = customBackground
//        return cell
//    }

}
