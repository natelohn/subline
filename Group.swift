//
//  Group.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation

class Group {
    
    var parseID = ""
    var name = ""
    
    ///////////////////////////
    
    var creator = ""
    var members = [User]()
    var subgroups = [Subgroup]()
    
    
    func makeNewGroup(creator:String, name:String){
        self.creator = creator
        self.name = name
    }
    
    
    func updateName(newName:String){
        name = newName
    }
    
    func addMember(newMemberUsername:String){

    }
    
    func removeMember(exMember:User){
        for (index, member) in members.enumerate() {
            if member.username == exMember.username{
                members.removeAtIndex(index)
            }
        }
    }
    
    func addSubgroup(newSubgroup:Subgroup){
        subgroups.append(newSubgroup)
    }
    
    func removeSubgroup(exSubgroup:Subgroup){
        for (index, subgroup) in subgroups.enumerate() {
            if subgroup == exSubgroup{
                subgroups.removeAtIndex(index)
            }
        }
    }
    
}