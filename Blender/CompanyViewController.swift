//
//  CompanyViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class CompanyViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var productDatas = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        productDatas = ["", "", "", "", "",
                        "", "", "", "", ""]

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    // MARK: UITableViewDataSource Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDatas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("product", forIndexPath: indexPath) 
        return cell
    }
}
