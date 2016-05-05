//
//  DataBase.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift


class DataBase {
    
    let realm = try! Realm()
    
    func isUser(username:String) -> Bool {
        let user = realm.objects(User).filter("username == '\(username)'").first
        return user != nil
    }
    
    
    //will crash if group is not in system
    func getUserFromDB(username:String) -> User{
        let user = realm.objects(User).filter("username == '\(username)'").first
        return user!
    }
    
    
    func printAllUsers(){
        print("-----all users-----")
        let users = realm.objects(User)
        for user in users {
            user.printAllGroups()
        }
    }
    
    func clearDB(){
        try! realm.write {
            realm.deleteAll()
        }
    }
}
