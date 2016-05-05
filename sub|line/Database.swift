//
//  Database.swift
//  subline
//
//  Created by Nate Lohn on 5/3/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation



//a temporary class until a database is set up
class Database {
    
    private var database = [String:User]()
    
    func addUser(user:User){
        database[user.username] = user
    }
    
    func removeUser(user:User){
        database[user.username] = nil
    }
    
    private func isUser(username:String) -> Bool{
        return database[username] != nil
    }
    
    func isUserPassword(user:User, password:String) -> Bool{
        if isUser(user.password){
            return database[user.username] == password
        } else {
            print("login failed")
            return false
        }
        
    }
}