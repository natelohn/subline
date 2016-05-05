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
    
    func signUp(username:String, password:String) -> Bool{
        let newUser = User()
        newUser.makeNewUser(username, password: password)
        let existingUser = realm.objects(User).filter("username == '\(username)'").first
        if existingUser == nil {
            try! realm.write() {
                print("new user signed up!")
                realm.add(newUser)
            }
            return true //shouldn't this be in the try statement? no... no it shouldn't
        } else {
            print("username exists")
            return false
        }
    }
}
