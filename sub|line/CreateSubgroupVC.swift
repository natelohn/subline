//
//  CreateSubgroupVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import RealmSwift

class CreateSubgroupVC: UIViewController {
    
    
    let brain = SubgroupBrain()
    
    let db = DataBase()
    var username:String = ""
    var user = User()
    var subgroup = Subgroup()
    var members = Set<String>()
    
    @IBOutlet weak var subgroupTextField: UITextField!
    @IBOutlet weak var memberTextField: UITextField!
    
    override func viewDidLoad() {
        user = db.getUserFromDB(username)
        print("user: \(user.username)")
        print("group:\(subgroup.name)")
    }

    @IBAction func addSubgroupPushed(sender: UIButton) {
        let groupName = subgroupTextField.text!
        subgroup = brain.createSubgroup(user.username, name: groupName, members:List<User>())
    }
    
    @IBAction func addMemberPushed(sender: UIButton) {
        let memberName = memberTextField.text!
        members.insert(memberName)
    }

    @IBAction func createSubgroupPushed(sender: UIButton) {
        brain.addMemebersToSubgroup(members, subgroup: subgroup)
    }
}
