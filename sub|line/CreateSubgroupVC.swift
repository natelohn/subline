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
    
    var db = DataBase()
    var username = ""
    var groupName = ""
    
    @IBOutlet weak var subgroupTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    
    override func viewDidLoad() {
        print("Create Subgroup's user = \(username)")
        print("Create Subgroup's groupname = \(groupName)")
    }
    

    @IBAction func createSubgroupPushed(sender: UIButton) {
        let subgroupName = subgroupTextField.text!
        let subgroupDescription = descriptionTextField.text!
        if subgroupName != "" &&  subgroupDescription != "" && !db.subgroupNameExists(subgroupName){
            print("created group!")
            db.addSubgroup(subgroupName, description: subgroupDescription, groupName: groupName)
        } else {
            let alert = UIAlertController(title: "Invalid Info", message: "Please Pick a new Subgroup Name and have a Description", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Fine!!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        subgroupTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllSubgroupsVC"{
            let DestinationViewController : AllSubgroupsVC = segue.destinationViewController as! AllSubgroupsVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
        }
        
    }
    
}
