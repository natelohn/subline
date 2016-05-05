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
    
    func getUserFromDB(username:String) -> User{
        let user = realm.objects(User).filter("username == '\(username)'").first
        return user!
    }
    
    func printAllUsers(){
        let users = realm.objects(User)
        print(users)
    }
    
    func clearDB(){
        try! realm.write {
            realm.deleteAll()
        }
    }
}
