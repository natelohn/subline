//
//  AllSubgroupVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class AllSubgroupsVC: UIViewController {
    
    @IBOutlet weak var subgroupTableView: UITableView!
    @IBOutlet weak var groupButton: UIButton!
    
    var db = DataBase()
    var username = ""
    var groupName = ""
    var selectedSubgroupName = ""
    var subgroupNames = [String]()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("All subgroup's user = \(username)")
        print("All subgroup's group = \(groupName)")
        subgroupNames = db.getAllSubgroupNamesInGroup(groupName)
        subgroupTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        groupButton.titleLabel!.text! = groupName
    }
    
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subgroupNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = subgroupTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = subgroupNames[indexPath.row] //name of group
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSubgroupName = subgroupNames[indexPath.row]
        self.performSegueWithIdentifier("toSubgroupVC", sender: self) //not sure if self should be something else
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
        }
        if segue.identifier == "toCreateSubgroupVC"{
            let DestinationViewController : CreateSubgroupVC = segue.destinationViewController as! CreateSubgroupVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
        }
        
        if segue.identifier == "toSubgroupVC"{
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
            DestinationViewController.subgroupName = selectedSubgroupName
//            DestinationViewController.posts = db.getAllPostsInSubgroup(selectedSubgroupName)
        }
    }
    
    
    
    
   

}
