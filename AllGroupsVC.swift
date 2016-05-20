//
//  AllGroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class AllGroupsVC: UIViewController {
    
    @IBOutlet weak var groupTableView: UITableView!
    
    var db = DataBase()
    var username = ""
    var selectedGroupName = ""
    var groupnames = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("All Groups VC's user = \(username)")
        groupnames = db.getAllUsersGroupNames(username)
        print("All groups VC groupnames = \(groupnames)")
        groupTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupnames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = groupnames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedGroupName = groupnames[indexPath.row]
        print("selected = \(selectedGroupName)")
        self.performSegueWithIdentifier("toAllSubgroupsVC", sender: self) //not sure if self should be something else
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreateGroupVC"{
            let DestinationViewController : CreateGroupVC = segue.destinationViewController as! CreateGroupVC
            DestinationViewController.username = username
        }
        
        if segue.identifier == "toAllSubgroupsVC"{
            let DestinationViewController : AllSubgroupsVC = segue.destinationViewController as! AllSubgroupsVC
            DestinationViewController.username = username
            DestinationViewController.groupName = selectedGroupName
        }
        
        if segue.identifier == "toMenuVC"{
            let DestinationViewController : MenuVC = segue.destinationViewController as! MenuVC
            DestinationViewController.username = username
        }
    }
    

    

}
