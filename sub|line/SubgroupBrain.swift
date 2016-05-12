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
    
    func createSubgroup(group:Group, creatorUsername:String, name:String, description:String, members:Set<String>){
        let newSubgroup = Subgroup()
        newSubgroup.makeNewSubgroup(creatorUsername, name: name, descript:description)
        newSubgroup.addMember(creatorUsername)
        for member in members {
            newSubgroup.addMember(member)
        }
        group.addSubgroup(newSubgroup)
    }
    
}