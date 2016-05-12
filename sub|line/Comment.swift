//
//  Comment.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {
    
    dynamic var commentor = ""
    dynamic var comment = ""
    dynamic var timeString = ""
    dynamic var score = 0
    let upvotes = List<User>()
    let downvotes = List<User>()
    
    
    func createComment(commentor:String, comment:String){
        self.commentor = commentor
        self.comment = comment
        timeString = makeDateString(NSDate())
    }
    
    func makeDateString(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        return "at " + String(components.hour) + ":" + String(components.minute)
    }

    
    func updateScore(add:Int){
        try! Realm().write {
            score = score + add
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
    
}
