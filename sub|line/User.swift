//
//  User.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift



class User: Object {
    
    dynamic var username = ""
    dynamic var password = ""
//    dynamic var groups = Group[]()
    
    
    func makeNewUser(username: String, password: String){
        self.username = username
        self.password = password
        
    }
    
    func setNewUsername(newUsername:String){
        self.username = newUsername
    }
    
    func setNewPassword(newPassword:String){
        self.password = newPassword
    }
    
}

