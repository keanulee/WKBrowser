//
//  TableViewController.swift
//  WKBrowser
//
//  Created by Keanu Lee on 9/27/14.
//  Copyright (c) 2014 Keanu Lee. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var bookmarks: [String] {
        get {
            var returnValue : [String]? = NSUserDefaults.standardUserDefaults().objectForKey("urls") as? [String]
            if returnValue == nil { //Check for first run of app
                returnValue = [
                    "http://www.polymer-project.org/apps/topeka/",
                    "http://www.polymer-project.org/components/core-scroll-header-panel/demo.html"
                ]
            }
            return returnValue!
        }
        set (newValue) {
            //  Each item in newValue is now a NSString
            let val = newValue as [NSString]
            NSUserDefaults.standardUserDefaults().setObject(val, forKey: "urls")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = Selector("addButtonClicked")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Add URL alert controller
    
    @IBOutlet var newURLField: UITextField?
    
    func wordEntered(alert: UIAlertAction!){
        bookmarks.insert(self.newURLField!.text, atIndex: 0)
        
        // TODO: make animation
        tableView.reloadData()
    }

    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "http://"
        self.newURLField = textField
    }
    
    func addButtonClicked() {
        // display an alert
        let newWordPrompt = UIAlertController(title: "Enter URL", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: wordEntered))
        presentViewController(newWordPrompt, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = bookmarks[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            bookmarks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath from: NSIndexPath, toIndexPath to: NSIndexPath) {
        var url: String = bookmarks[from.row]
        bookmarks.removeAtIndex(from.row)
        bookmarks.insert(url, atIndex: to.row)
    }

    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "openurl" {
            let selectedRow = tableView.indexPathForSelectedRow()?.row
            let viewController = segue.destinationViewController as ViewController
            viewController.url = bookmarks[selectedRow!]
        }
    }
}
