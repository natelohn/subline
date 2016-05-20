//
//  User.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift
import Parse



class User {
    
    var username = ""
    var password = ""
    
    
    ///////////////////
    var groups = [Group]()
    let subgroups = List<Subgroup>()
    
    func makeNewUser(username: String, password: String){
        self.username = username
        self.password = password
        
    }
    
    func setNewUsername(newUsername:String){
        self.username = newUsername
    }
    
    func setNewPassword(newPassword:String){
        self.password = newPassword
    }
    
    func addGroup(newGroup:Group){
        groups.append(newGroup)
    }
    
    
    func removeGroup(exGroup:Group){
        for (index, group) in groups.enumerate() {
            if group.name == exGroup.name{
                groups.removeAtIndex(index)
            }
        }
    }
    
    func addSubgroup(newSubgroup:Subgroup){
        
        try! Realm().write {
            subgroups.append(newSubgroup)
        }
    }
    
    
    func removeSubgroup(exSubgroup:Subgroup){
        for (index, subgroup) in subgroups.enumerate() {
            if subgroup == exSubgroup{
                subgroups.removeAtIndex(index)
            }
        }
    }
    
}

