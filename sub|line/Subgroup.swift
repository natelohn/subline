//
//  Subgroup.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift


class Subgroup: Object {
    
    dynamic var name = ""
    dynamic var creator = ""
    dynamic var descript = ""
    let members = List<User>()
    let posts = List<Post>()
    
    
    
    func makeNewSubgroup(creator:String, name:String, descript:String){
        self.creator = creator
        self.name = name
        self.descript = descript
    }
    
    
    func updateName(newName:String){
        name = newName
    }
    
    func addMember(username:String){
        let newMember = DataBase().getUserFromDB(username)
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
  
    func addPost(post:Post){
        //to get posts to start at bottom, try adding a lot of blank posts & reversing the array on return
        try! Realm().write {
            posts.append(post)
        }
    }
    
    
}

