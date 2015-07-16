//
//  RecipeViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var recipeDatas = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        recipeDatas = ["", "", "", "", "", "", "", "", "", ""]

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }


    // MARK: UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDatas.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("recentRecipe", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }

//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return teacherDatas.count
//    }
//
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TeacherInfoCell", forIndexPath: indexPath) as! TeacherInfoCell
//
//        // TODO: Dynamic Load Data and Upate Cell UI
//
//        return cell
//    }
//
//    // MARK: UICollectionViewDelegateFlowLayout Methods
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//        let height = self.cellHeight * 0.5
//        let width = collectionView.frame.size.width * 0.5
//        return CGSizeMake(width, height)
//    }

}
