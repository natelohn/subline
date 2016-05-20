//
//  MenuVC.swift
//  subline
//
//  Created by Nate Lohn on 5/20/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var feedbackTextField: UITextField!
    
    let db = DataBase()
    var username = "user_not_found"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text! = "Logged in as " + username
    }


    @IBAction func sendFeedbackButtonPushed(sender: AnyObject) {
        let feedback = feedbackTextField.text!
        db.addFeedback(username, text:feedback)
        feedbackTextField.text = ""
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
            DestinationViewController.groupnames = db.getAllUsersGroupNames(username)
        }
    }
}
