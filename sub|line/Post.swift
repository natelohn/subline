//
//  Post.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation


class Post {
    private var user = "" //will be a user object
    private var text = ""
    private var score = 0 
    private var postHour = ""
    private var postMinute = ""
    private var comments = [String]() //comment needs to be it's own class
    //array of votes
    //var score:int
    //time of post
    
    
    func setUser(input:String){
        user = input
    }
    
    func getUser() -> String {
        return user
    }
    
    func setText(input:String) {
        text = input
    }
    
    func getText() -> String {
        return text
    }
    
    func updateScore(add:Int){
        score = score + add
    }
    
    func getScore() -> Int {
        return score
    }
    
    func setDate(date:NSDate) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        postHour = String(components.hour)
        postMinute = String(components.minute)
    }
    
    func getDate() -> String {
        return "at " + postHour + ":" + postMinute
    }
}