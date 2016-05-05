//
//  GroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import RealmSwift

class CreateGroupsVC: UIViewController {
    
    let brain = GroupBrain()
    
    let db = DataBase()
    var user = User()
    var username = ""
    var group = Group()
    var members = Set<String>()
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var memberNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        user = db.getUserFromDB(username)
        print("user = \(user.username)")
    }
    
    @IBAction func addGroupButtonPushed(sender: UIButton) {
        let groupName = groupNameTextField.text!
        group = brain.createGroup(user.username, name: groupName, members:List<User>())
        user.printAllGroups()
    }
    
    
    @IBAction func addMemberPushed(sender: UIButton) {
        let memberName = memberNameTextField.text!
        members.insert(memberName)
        print("\(memberName) added")
    }
    
    
    @IBAction func createGroupPushed(sender: UIButton) {
        brain.addMemebersToGroup(members, group: group)
        
        
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
                let DestinationViewController : CreateGroupsVC = segue.destinationViewController as! CreateGroupsVC
                DestinationViewController.username = username
            }
        }
    }
    
    
    
    
    
    
    
}
