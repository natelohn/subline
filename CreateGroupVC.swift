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
        user = db.getUserFromDB(username)
        print("user = \(user.username)")
    }
    
    @IBAction func addGroupButtonPushed(sender: UIButton) {
        let groupName = groupNameTextField.text!
        group = brain.createGroup(user.username, name: groupName, members:List<User>())
        user.printAllGroups()
    }
    
    
//    @IBAction func addMemberPushed(sender: UIButton) {
//        let memberName = memberNameTextField.text!
//        members.insert(memberName)
//        print("\(memberName) added")
//    }
    
    
    @IBAction func createGroupPushed(sender: UIButton) {
        brain.addMemebersToGroup(members, group: group)
    }
    
    
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.getAllUsers().count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        var skipSelf = 0
        if db.getAllUsers()[indexPath.row].username == username {
            skipSelf = 1
        }
        let cell = allUsersTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = db.getAllUsers()[indexPath.row + skipSelf].username
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
//        self.performSegueWithIdentifier("toCreateGroupsVC", sender: self) //not sure if self should be something else
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    
    //segue logic
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toCreateSubgroupVC" {
            if  username == "" {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if username != "" {
            if segue.identifier == "toCreateSubgroupVC"{
                let DestinationViewController : CreateGroupVC = segue.destinationViewController as! CreateGroupVC
                DestinationViewController.username = username
            }
        }
    }
    
    
    
    
    
    
    
}
