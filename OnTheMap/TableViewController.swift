//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/11/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseClient.sharedInstance().studentInfo.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentInfoCell")!
        let studentInfo = ParseClient.sharedInstance().studentInfo[indexPath.row]
        
        cell.textLabel?.text = studentInfo.firstName + " " + studentInfo.lastName
        
        return cell
    }
}