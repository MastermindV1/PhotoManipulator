//
//  MainTableViewController.swift
//  PhotoManipulator
//
//  Created by Basement on 11/2/15.
//  Copyright © 2015 Mohanad. All rights reserved.
//

import UIKit

class MainTableViewController : UITableViewController{
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell") as! MainTableViewCell
        var pictureArray = PhotoStore.sharedInstance.picArray
        let photo = pictureArray[indexPath.row]
        tableCell.thumbnailView.image = PhotoStore.sharedInstance.getPicture(photo.photoLocation!)
        tableCell.nameLabel.text = photo.name
        return tableCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pictureArray = PhotoStore.sharedInstance.picArray
        return pictureArray.count
    }
    
}