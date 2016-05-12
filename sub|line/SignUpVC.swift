//
//  SignUpVC.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let brain = SignUpBrain()
    
    var user = User()
    var username:String = ""
    
    @IBAction func signupButtonPushed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if brain.signUp(username, password: password){
            self.username = username
//            print("user set")
            self.performSegueWithIdentifier("toAllGroupsVC", sender: sender)
        } else {
            let alert = UIAlertController(title: "Failed Sign Up", message: "Please Pick a New Username", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Awww... I liked that one.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
//            print("failed sign up")
        }
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
    }
    
}
