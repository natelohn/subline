//
//  LoginBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.

//

import Foundation
import RealmSwift


class LoginBrain {
    
    let realm = try! Realm()
    
    func login(username:String, password:String) -> Bool{
        let user = realm.objects(User).filter("username == '\(username)' AND password == '\(password)'").first
        return user != nil
    }
    
}
