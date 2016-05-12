//
//  Post.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift

class Post : Object{
    dynamic var creator = ""
    dynamic var title = ""
    dynamic var descript = ""
    dynamic var time = ""
    private dynamic var score = 0
    let upvotes = List<User>()
    let downvotes = List<User>()
    let comments = List<Comment>()
    //time of post
    
    func createPost(creator:String, title:String, description:String, date:NSDate){
        self.creator = creator
        self.title = title
        self.descript = description
        self.time = makeDateString(date)
    }
    
    
    func updateScore(add:Int){
        try! Realm().write {
            score = score + add
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func makeDateString(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        return "at " + String(components.hour) + ":" + String(components.minute)
    }
    
    func addVote(username:String, up:Bool){
        let user = DataBase().getUserFromDB(username)
        if up {
            try! Realm().write {
                upvotes.append(user)
                if votedDown(username){
                    downvotes.removeAtIndex(downvotes.indexOf(user)!)
                }
            }
        } else {
            try! Realm().write {
                downvotes.append(user)
                if votedUp(username){
                    upvotes.removeAtIndex(upvotes.indexOf(user)!)
                }
            }
        }
    }
    
    func votedUp(username:String) -> Bool{
        for user in upvotes{
            if user.username == username {
                return true
            }
        }
        return false
    }
    
    func votedDown(username:String) -> Bool{
        for user in downvotes{
            if user.username == username {
                return true
            }
        }
        return false
    }
    
    func addComment(newComment:Comment){
        try! Realm().write{
            comments.append(newComment)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}