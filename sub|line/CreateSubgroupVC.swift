//
//  CreateSubgroupVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import RealmSwift

class CreateSubgroupVC: UIViewController {
    
    
    let brain = SubgroupBrain()
    
    let db = DataBase()
    var username = ""
    var user = User()
    var group = Group()
    var subgroup = Subgroup()
    var members = Set<String>()
    
    @IBOutlet weak var subgroupTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    
    override func viewDidLoad() {
        print("Create Subgroup's user = \(username)")
        print("Create Subgroup's group = \(group.name)")
    }
    

    @IBAction func createSubgroupPushed(sender: UIButton) {
        let subgroupName = subgroupTextField.text!
        let subgroupDescription = descriptionTextField.text!
        if subgroupName != "" &&  subgroupDescription != ""{
            print("created group!")
            brain.createSubgroup(group, creatorUsername: username, name: subgroupName, description: subgroupDescription, members: members)
        } else {
            let alert = UIAlertController(title: "Not Enough Info", message: "Please Add a Subgroup Name and Description", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Fine!!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSelectUsersVC"{
            let DestinationViewController : SelectUsersVC = segue.destinationViewController as! SelectUsersVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.usersToDisplay = Array(group.members)
            DestinationViewController.selectingGroupMembers = false
        }
        if segue.identifier == "toAllSubgroupsVC"{
            let DestinationViewController : AllSubgroupsVC = segue.destinationViewController as! AllSubgroupsVC
            DestinationViewController.username = username
            DestinationViewController.group = group
        
        }
        
    }
    
}
