//
//  User.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift



class User: Object {
    
    dynamic var username = ""
    dynamic var password = ""
    let groups = List<Group>()
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
        
        try! Realm().write {
            groups.append(newGroup)
        }
    }
    
    
    func removeGroup(exGroup:Group){
        for (index, group) in groups.enumerate() {
            if group == exGroup{
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
    
    
    
    
    //temp
    func printAllGroups(){
        print("User: \(username)")
        for group in groups {
            print("     Group: \(group.name)")
            print("     Creator: \(group.creator)")
            for member in group.members {
                print("         Member:\(member.username)")
            }
            for subgroup in group.subgroups {
                print("             Subgroup:\(subgroup.name)")
                print("             Creator:\(subgroup.creator)")
                for submember in subgroup.members {
                    print("             Member:\(submember.username)")
                }
            }

            
        }
    }
    
}

