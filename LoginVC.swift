//
//  LoginVC.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let brain = LoginBrain()
    
    var user = User()
    var username:String = ""
    
    @IBAction func loginPushed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if(brain.login(username, password: password)){
            print("login sucess!")
            self.username = username
            self.performSegueWithIdentifier("toGroupVC", sender: sender)
        } else {
            print("login failed :_(")
            let alert = UIAlertController(title: "Failed Login", message: "Incorrect Username or Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Shit... I forgot it.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //segue logic
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "toGroupVC" {
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
            if segue.identifier == "toGroupVC"{
                let DestinationViewController : GroupsVC = segue.destinationViewController as! GroupsVC
                DestinationViewController.username = username
            }
        }
    }
    
}
