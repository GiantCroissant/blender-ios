//
//  RecipeViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/16/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var recentRecipesView: UIView!
    @IBOutlet weak var hotRecipesView: UIView!
    @IBOutlet weak var segmentedControlView: AYOSegmentedControl!
    

    var recentRecipesVC: RecipeTableViewController!
    var hotRecipesVC: RecipeTableViewController!

    var resultSearchController = UISearchController()

    var recipeDatas = [String]()
    var filteredRecipeDatas = [String]()

    @IBAction func searchActive(sender: UIBarButtonItem)
    {
        self.tableView.hidden = false
        self.resultSearchController.active = true;
    }

    func presentSearchController(searchController: UISearchController)
    {
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.resultSearchController.searchBar.becomeFirstResponder()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        self.resultSearchController.active = false;
        self.tableView.tableHeaderView = nil
        self.tableView.hidden = true
    }

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        print("selectedScope \(selectedScope)")
    }


//    func searchBarResultsListButtonClicked(searchBar: UISearchBar)
//    {
//        print("test")
//
//        self.resultSearchController.active = false;
//        self.tableView.tableHeaderView = nil
//        self.tableView.hidden = true
//
//        self.performSegueWithIdentifier("toRecipeDetail", sender: nil)
//    }

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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.hidden = true

        recipeDatas = ["蘋果汁", "蘋果奇異果汁", "蘋果鳳梨汁", "", "", "", "", "", "", ""]

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        for vc in self.childViewControllers
        {
            if vc.isKindOfClass(RecipeTableViewController)
            {
                print("hello world : \(vc.title)")
                if let name = vc.title
                {
                    if name == "recent"
                    {
                        recentRecipesVC = vc as! RecipeTableViewController
                    }
                }
            }
        }

        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.delegate = self
        self.resultSearchController.searchBar.delegate = self

        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()

        self.resultSearchController.searchBar.barTintColor = UIColor(rgba: "#7db343")

        self.resultSearchController.searchBar.tintColor = UIColor(rgba: "#FFFFFF")
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
        if self.resultSearchController.active
        {
            return self.filteredRecipeDatas.count
        }
        else
        {
            return self.recipeDatas.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        if self.resultSearchController.active
        {
            cell.textLabel?.text = self.filteredRecipeDatas[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = self.recipeDatas[indexPath.row]
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {


        print("test")
        self.resultSearchController.active = false;
        self.tableView.tableHeaderView = nil
        self.tableView.hidden = true

        self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("storyBoardIdentifier"))!, animated: true)

    }

}
