//
//  GroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var memberNameTextField: UITextField!
    
    
    let brain = GroupBrain()
    
    let db = DataBase()
    var user = User()
    var username:String = ""
    
    
    override func viewDidLoad() {
        user = db.getUserFromDB(username)
        print("user = \(user.username)")
    }
    
    @IBAction func addGroupButtonPushed(sender: UIButton) {
        let groupName = groupNameTextField.text!
        print("\(groupName)")
        
    }
    
    
    @IBAction func addMemberPushed(sender: UIButton) {
        let memberName = memberNameTextField.text!
        print("\(memberName)")
        
    }
    
    
    
}
