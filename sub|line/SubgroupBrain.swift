//
//  SubgroupBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift

class SubgroupBrain {
    
    let db = DataBase()
    
    func createSubgroup(creatorUsername:String, name:String, members:List<User>) -> Subgroup {
        let newSubgroup = Subgroup()
        let creator = db.getUserFromDB(creatorUsername)
        newSubgroup.makeNewSubgroup(creatorUsername, name: name, members: members)
        newSubgroup.addMember(creator)
        creator.addSubgroup(newSubgroup)
        return newSubgroup
    }
    
    func addMemebersToSubgroup(memberUsernames:Set<String>, subgroup:Subgroup){
        for username in memberUsernames {
            if db.isUser(username){
                let user = db.getUserFromDB(username)
                subgroup.addMember(user)
            }
        }
        db.printAllUsers()
    }
    
    
    
    
    
}