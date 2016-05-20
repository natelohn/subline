//
//  LoginVC.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let db = DataBase()
    let brain = LoginBrain()
    
    var username = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let testObj = PFObject(className: "User")
//        testObj.saveInBackground()
////        db.addUser("test2", password: "1")
////        db.addGroup("test group", memberUsernames: ["test1", "test2"])
    }
    
    
    @IBAction func loginPushed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if brain.login(username, password: password) {
            self.username = username

        } else {
            let alert = UIAlertController(title: "Failed Login", message: "Incorrect Username or Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Shit... I forgot it.", style: UIAlertActionStyle.Default, handler: nil))
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
    
    //to move the screen up/down
    func textFieldDidBeginEditing(textField: UITextField) {
        print("edit ")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("end edit")
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "toAllGroupsVC" {
            if  username == ""{
                return false
            }
            if !brain.login(username, password:passwordTextField.text!){
                print("will not segue")
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
            DestinationViewController.groupnames = db.getAllUsersGroupNames(username)
        }
    }
}
