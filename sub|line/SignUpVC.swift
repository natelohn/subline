//
//  SignUpVC.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let db = DataBase()
    let brain = SignUpBrain()
    var username = ""
    
    override func viewDidLoad() {
    }
    
    
    @IBAction func signupButtonPushed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if brain.signUp(username, password: password){
            self.username = username
            self.performSegueWithIdentifier("toAllGroupsVC", sender: sender)
        } else {
            let alert = UIAlertController(title: "Failed Sign Up", message: "Please Pick a New Username", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Awww... I liked that one.", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    

    
    
    
    //keyboard logic
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
        //remove this segue
        if segue.identifier == "toAllGroupsVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
            
        }
        if segue.identifier == "toCreateGroupVC"{
            let DestinationViewController : AllGroupsVC = segue.destinationViewController as! AllGroupsVC
            DestinationViewController.username = username
        }
    }
    
}
