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
    var username = ""
    
    @IBAction func loginPushed(sender: UIButton) {
//        DataBase().clearDB()
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if(brain.login(username, password: password)){
            self.username = username
        } else {
            let alert = UIAlertController(title: "Failed Login", message: "Incorrect Username or Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Shit... I forgot it.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
        }
    }
    
}
