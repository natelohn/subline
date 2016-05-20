//
//  SignUpBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import Parse


class SignUpBrain {
    
    let db = DataBase()

    
    func signUp(newUsername:String, password:String) -> Bool {
        let allUsernames = db.getAllUsernames()
        var willSignUp = true
        if newUsername == "" || password == ""{
            willSignUp = false
        } else {
            for username in allUsernames {
                if  username == newUsername{
                    willSignUp = false
                }
            }
        }
        if willSignUp {
            
            db.addUser(newUsername, password:password)
        }
        return willSignUp
    }
}
