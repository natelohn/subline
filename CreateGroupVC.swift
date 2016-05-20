//
//  GroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class CreateGroupVC: UIViewController {
    
    let brain = GroupBrain()
    
    var db = DataBase()
    var username = ""
    var groupName = ""
    var memberUsernames = [String]()
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var allUsersTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allUsersTableView.allowsMultipleSelection = true
        print("Create New Group's user = \(username)")
    }
    
    
    @IBAction func createGroupPushed(sender: UIButton) {
        let groupName = groupNameTextField.text!
        if groupName != "" && !db.groupNameExists(groupName){
            print("created group!")
            memberUsernames.append(username)
            db.addGroup(groupName, memberUsernames:memberUsernames)
        } else {
            let alert = UIAlertController(title: "Invalid Group Name", message: "Please Pick a Different Group Name", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Fine!!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(memberUsernames).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = allUsersTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = memberUsernames[indexPath.row]
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let memberName:String = (allUsersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
//        members.insert(memberName)
//        print("\(memberName) added")
//    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        let memberName:String = (allUsersTableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
//        members.remove(memberName)
//        print("\(memberName) removed")
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    //text logic
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        groupNameTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //segue logic
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
        }
        
        if segue.identifier == "toSelectUsersVC"{
            let DestinationViewController : SelectUsersVC = segue.destinationViewController as! SelectUsersVC
            DestinationViewController.username = username
            DestinationViewController.usernamesToDisplay = db.getAllOtherUsernames(username)
        }
    }
    
    
    
    
    
    
    
}
