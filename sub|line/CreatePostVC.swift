//
//  CreatePostVC.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class CreatePostVC: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextFIeld: UITextField!
    
    let brain = PostBrain()
    
    let db = DataBase()
    var username = ""
    var groupName = ""
    var subgroupName = ""
    
    var group = Group()
    var subgroup = Subgroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Create Post's username = \(username)")
        print("Create Post's group = \(groupName)")
        print("Create Post's subgroup = \(subgroupName)")
    }
    
    
    @IBAction func postButtonPushed(sender: UIButton) {
        let title = titleTextField.text!
        let description = descriptionTextFIeld.text!
        let key = title + description
        if title != "" && description != "" && !db.postKeyExists(key){
            print("post!")
            db.addPost(username, title: title, description: description, key:key, subgroupName:subgroupName)
        } else {
            let alert = UIAlertController(title: "Invalid Info", message: "Please Edit the Title or Description", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Whoops!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toSubgroupVC" {
            let key = titleTextField.text! + descriptionTextFIeld.text!
            if  titleTextField.text! == "" || descriptionTextFIeld.text! == "" || db.postKeyExists(key) {
                return false
            }
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        descriptionTextFIeld.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSubgroupVC" || segue.identifier == "toSubgroupVC2" {
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
            DestinationViewController.subgroupName = subgroupName
//            DestinationViewController.posts = db.getAllPostsInSubgroup(subgroupName)
            
        }
        
    }
    
}
