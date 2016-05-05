//
//  Group.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object {
    
    dynamic var creator = ""
    dynamic var name = ""
    let members = List<User>()
    let subgroups = List<Subgroup>()
    //array of subgroups
    
    func makeNewGroup(creator:String, name:String, members:List<User>){
        self.creator = creator
        self.name = name
        self.members.appendContentsOf(members) //members may need to be it's own object extending user
    }
    
    
    func updateName(newName:String){
        name = newName
    }
    
    func addMember(newMember:User){
        try! Realm().write {
            members.append(newMember)
        }
    }
    
    func removeMember(exMember:User){
        for (index, member) in members.enumerate() {
            if member == exMember{
                members.removeAtIndex(index)
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