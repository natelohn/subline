//
//  SelectUsersVC.swift
//  subline
//
//  Created by Nate Lohn on 5/9/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class SelectUsersVC: UIViewController {
    
//    let brain = SelectUsersBrain()
    
    var username = ""
    var usersToDisplay = [User]()
    var selectedUsernames = Set<String>()
    var selectingGroupMembers = true
    var group = Group()
    
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var addToGroupButton: UIButton!
    @IBOutlet weak var addToSubgroupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersTableView.allowsMultipleSelection = true
        print("Select Users username = \(username)")
        print("Selecting Users group = \(group.name)")
        if selectingGroupMembers {
            addToSubgroupButton.hidden = true
        } else {
            addToGroupButton.hidden = true
        }
    }
    
    
    
    @IBAction func addPushed(sender: AnyObject) {
        if selectingGroupMembers {
            performSegueWithIdentifier("toCreateGroupVC", sender: nil)
        } else {
            performSegueWithIdentifier("toCreateSubgroupVC", sender: nil)
        }
    }
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = usersTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = usersToDisplay[indexPath.row].username
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memberName = (usersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
        selectedUsernames.insert(memberName)
        print("\(memberName) added")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let memberName:String = (usersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
        selectedUsernames.remove(memberName)
        print("\(memberName) removed")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreateGroupVC"{
            let DestinationViewController : CreateGroupVC = segue.destinationViewController as! CreateGroupVC
            DestinationViewController.username = username
            DestinationViewController.members = selectedUsernames
        }
        if segue.identifier == "toCreateSubgroupVC"{
            let DestinationViewController : CreateSubgroupVC = segue.destinationViewController as! CreateSubgroupVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.members = selectedUsernames
        }
    }
    


}
