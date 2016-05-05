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
    let members = List<User>()
    //list of posts
    
    
    
    func makeNewSubgroup(creator:String, name:String, members:List<User>){
        self.creator = creator
        self.name = name
        self.members.appendContentsOf(members)
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
  
//    func addPost(post:Post){
//        //to get posts to start at bottom, try adding a lot of blank posts & reversing the array on return
//        posts.append(post)
//    }
//    
//    func getAllPosts() -> [Post] {
//        return posts
//    }
//    
//    func printAllPosts() {
//        for post in posts{
//            print(post)
//        }
//    }
    
}

