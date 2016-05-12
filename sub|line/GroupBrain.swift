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
    
    func createGroup(creatorUsername:String, name:String, members:Set<String>){
        let newGroup = Group()
        newGroup.makeNewGroup(creatorUsername, name: name)
        newGroup.addMember(creatorUsername)
        for member in members {
            newGroup.addMember(member)
        }
    }
}