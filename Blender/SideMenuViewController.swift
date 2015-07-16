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

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.selected {
            cell.backgroundColor = UIColor.blackColor()
        } else {
            cell.backgroundColor = tableView.backgroundColor
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! UITableViewCell
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }

}
