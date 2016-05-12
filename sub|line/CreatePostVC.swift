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
    
    var username = ""
    var group = Group()
    var subgroup = Subgroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Create Post's username = \(username)")
        print("Create Post's group = \(group.name)")
        print("Create Post's subgroup = \(subgroup.name)")
    }
    
    
    @IBAction func postButtonPushed(sender: UIButton) {
        let title = titleTextField.text!
        let description = descriptionTextFIeld.text!
        if title != "" && description != "" {
            print("post!")
            brain.createPost(subgroup, creator: username, title: title, description: description)
        } else {
            let alert = UIAlertController(title: "Not Enough Info", message: "Please Add a Title and Description", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Whoops!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toSubgroupVC" {
            if  titleTextField.text! == "" || descriptionTextFIeld.text! == "" {
                return false
            }
            return true
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSubgroupVC"{
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.subgroup = subgroup
            
        }
        
    }
    
}
