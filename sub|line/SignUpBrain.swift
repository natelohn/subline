//
//  SignUpBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift


class SignUpBrain {
    
    let realm = try! Realm()
    let db = DataBase()
    
    func signUp(username:String, password:String) -> Bool {
        if username == "" || password == ""{
            return false
        } else {
            if !db.isUser(username){
                let newUser = User()
                newUser.makeNewUser(username, password: password)
                try! realm.write() {
                    print("new user signed up!")
                    realm.add(newUser)
                }
                return true
            } else {
                print("username exists")
                return false
            }
        }
    }
}
