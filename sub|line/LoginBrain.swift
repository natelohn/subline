//
//  LoginBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import Parse


class LoginBrain {
    
    let db = DataBase()
    
    func login(username:String, password:String) -> Bool{
        if username == "" || password == ""{
            return false
        } else {
            let allUsers = db.getAllUsers()
            print(allUsers.count)
            for user in allUsers {
                let usernameString = user["username"] as! String
                let passwordString = user["password"] as! String
                if  usernameString == username && passwordString == password {
                    print("returns true")
                    return true
                }
            }
        }
        print("returns false")
        return false
        
    }
    
}
