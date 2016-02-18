//
//  RecipeViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit
import Gloss

class RecipeViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource
{
    @IBOutlet weak var segmentedControlView: AYOSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var recentRecipesView: UIView!
    @IBOutlet weak var hotRecipesView: UIView!

    var resultSearchController: UISearchController!
    var recipeDatas = [String]()
    var filteredRecipeDatas = [String]()

    @IBAction func searchActive(sender: UIBarButtonItem)
    {
        resultSearchController.active = true;
        tableView.hidden = false
    }

    func presentSearchController(searchController: UISearchController)
    {
        tableView.tableHeaderView = resultSearchController.searchBar
        resultSearchController.searchBar.becomeFirstResponder()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        resultSearchController.active = false;
        tableView.tableHeaderView = nil
        tableView.hidden = true
    }

    @IBAction func segmentValueChanged(sender: AYOSegmentedControl)
    {
        switch (sender.selectedIndex) {
        case 0:
            recentRecipesView.hidden = false
            hotRecipesView.hidden = true
            break

        case 1:
            recentRecipesView.hidden = true
            hotRecipesView.hidden = false
            break

        default:
            break
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.hidden = true
        recipeDatas = ["aaa", "bbb", "ccc", "", "", "", "", "", "", ""]
        if revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.delegate = self
        resultSearchController.searchBar.delegate = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.barTintColor = UIColor(rgba: "#7db343")
        resultSearchController.searchBar.tintColor = UIColor(rgba: "#FFFFFF")


      if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
        do {
          let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
          let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
          guard let recipeCollection = RecipeCollections(json: jsonResult as! JSON) else {
            print("Issue deserializing model")
            return
          }

          for recipe in recipeCollection.recipes {
            print(recipe)
          }

        } catch let error {
          print(error)
        }
      }

    }

    /*
        Fix iOS bug :

        "Attempting to load the view of a view controller
            while it is deallocating is not allowed and may result in undefined behavior"
    
        reference URL : http://goo.gl/g6OnkO
    */
    deinit
    {
        self.resultSearchController.view.removeFromSuperview()
    }

    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredRecipeDatas.removeAll(keepCapacity: false)
        let searchText = searchController.searchBar.text!.lowercaseString
        filteredRecipeDatas = recipeDatas.filter({ $0.lowercaseString.rangeOfString(searchText) != nil })
        tableView.reloadData()
    }

    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if resultSearchController.active
        {
            return filteredRecipeDatas.count
        }
        else
        {
            return recipeDatas.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if resultSearchController.active
        {
            cell.textLabel?.text = filteredRecipeDatas[indexPath.row]
        }
        else
        {
//            cell.textLabel?.text = self.recipeDatas[indexPath.row]
            cell.textLabel?.text = ""
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        resultSearchController.active = false
        tableView.tableHeaderView = nil
        tableView.hidden = true

        let vc = (self.storyboard?.instantiateViewControllerWithIdentifier("storyBoardIdentifier"))!
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
