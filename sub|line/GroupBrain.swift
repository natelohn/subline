//
//  GroupsBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift

class GroupBrain {
    
    let db = DataBase()
    
    func createGroup(creatorUsername:String, name:String, members:List<User>) -> Group{
        let newGroup = Group()
        let creator = db.getUserFromDB(creatorUsername)
        newGroup.makeNewGroup(creatorUsername, name: name, members: members)
        newGroup.addMember(creator)
        creator.addGroup(newGroup)
        return newGroup
    }
    
    func addMemebersToGroup(memberUsernames:Set<String>, group:Group){
        for username in memberUsernames {
            if db.isUser(username){
                let user = db.getUserFromDB(username)
                group.addMember(user)
            }
        }
        db.printAllUsers()
    }
    
    
    
    
    
}