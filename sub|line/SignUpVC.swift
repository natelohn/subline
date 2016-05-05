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
            print("user set")
            self.performSegueWithIdentifier("toCreateGroupVC", sender: sender)
        } else {
            let alert = UIAlertController(title: "Failed Sign Up", message: "Please Pick a New Username", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Awww... I liked that one.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            print("failed sign up")
        }
    }
    
    
    //segue logic 
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toCreateGroupVC" {
            if  username == "" {
                print("no segue")
                return false
            } else {
                print("segue")
                return true
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if username != "" {
            if segue.identifier == "toCreateGroupVC"{
                let DestinationViewController : CreateGroupsVC = segue.destinationViewController as! CreateGroupsVC
                DestinationViewController.username = username
            }
        }
    }
    
}
