//
//  AllSubgroupVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class AllSubgroupsVC: UIViewController {
    
    @IBOutlet weak var subgroupTableView: UITableView!
    
    let db = DataBase()
    var username = ""
    var user = User()
    var group = Group()
    var selectedSubgroup = Subgroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("All subgroup's user = \(username)")
        print("All subgroup's group = \(group.name)")
        user = db.getUserFromDB(username)
        subgroupTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.subgroups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = subgroupTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = group.subgroups[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("Row \(indexPath.row) selected")
        selectedSubgroup = group.subgroups[indexPath.row]
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
            DestinationViewController.group = group
        }
        
        if segue.identifier == "toSubgroupVC"{
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.subgroup = selectedSubgroup
            
        }
    }
    
    
    
    
   

}
