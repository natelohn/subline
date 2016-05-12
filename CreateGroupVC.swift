//
//  GroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import RealmSwift

class CreateGroupVC: UIViewController {
    
    let brain = GroupBrain()
    
    let db = DataBase()
    var user = User()
    var username = ""
    var group = Group()
    var members = Set<String>()
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var allUsersTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allUsersTableView.allowsMultipleSelection = true
        print("Create New Group's user = \(username)")
        
        user = db.getUserFromDB(username)
        
        
//        print("user = \(user.username)")
    }
    
    
    @IBAction func createGroupPushed(sender: UIButton) {
        let groupName = groupNameTextField.text!
        if groupName != "" {
            print("created group!")
            brain.createGroup(user.username, name: groupName, members:members)
        } else {
            let alert = UIAlertController(title: "No Group Name", message: "Please Add a Group Name", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Fine!!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(members).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = allUsersTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = Array(members)[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memberName:String = (allUsersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
        members.insert(memberName)
        print("\(memberName) added")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let memberName:String = (allUsersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
        members.remove(memberName)
        print("\(memberName) removed")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    
    //segue logic
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toAllGroupsVC" {
            if  username == "" {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
        }
        
        if segue.identifier == "toSelectUsersVC"{
            let DestinationViewController : SelectUsersVC = segue.destinationViewController as! SelectUsersVC
             DestinationViewController.username = username
            DestinationViewController.usersToDisplay = db.getAllOtherUsers(username)
        }
    }
    
    
    
    
    
    
    
}
