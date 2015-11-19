//
//  RecipeTableViewController.swift
//  Blender
//
//  Created by Bryan Lin on 7/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {

    var recipes = [String]()
    var resultSearchController = UISearchController()
    var filteredAppleProducts = [String]()

    // UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredAppleProducts.removeAll(keepCapacity: false)
        let searchText = searchController.searchBar.text!.lowercaseString
        filteredAppleProducts = recipes.filter({ $0.lowercaseString.rangeOfString(searchText) != nil })
        tableView.reloadData()
    }

    // UISearchBarDelegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        self.resultSearchController.active = false;
        self.tableView.tableHeaderView = nil
    }

    // UISearchControllerDelegate
    func presentSearchController(searchController: UISearchController)
    {
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.resultSearchController.searchBar.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        recipes = ["", "", "", "", "", "", "", "", "", ""]

        // custom UI
        self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)

        // setup UISearchController
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.delegate = self
        self.resultSearchController.searchBar.delegate = self

        self.resultSearchController.dimsBackgroundDuringPresentation = true
        self.resultSearchController.searchBar.sizeToFit()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) 

        // Configure the cell...

        return cell
    }

}
