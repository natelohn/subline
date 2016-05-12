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
    private dynamic var score = 0
    private dynamic var postHour = ""
    private dynamic var postMinute = ""
    let upvotes = List<User>()
    let downvotes = List<User>()
    //array of votes
    //var score:int
    //time of post
    
    func createPost(creator:String, title:String, description:String, date:NSDate){
        self.creator = creator
        self.title = title
        self.descript = description
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        postHour = String(components.hour)
        postMinute = String(components.minute)
    }
    
    
    func updateScore(add:Int){
        try! Realm().write {
            score = score + add
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getDate() -> String {
        return  postHour + ":" + postMinute
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}