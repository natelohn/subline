//
//  Subgroup.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import RealmSwift


class Subgroup {
    private var posts = [Post]()
    
    //hard coded post data
    
    //switch to init 
    
    
    func addPost(post:Post){
        //to get posts to start at bottom, try adding a lot of blank posts & reversing the array on return
        posts.append(post)
    }
    
    func getAllPosts() -> [Post] {
        return posts
    }
    
    func printAllPosts() {
        for post in posts{
            print(post)
        }
    }
    
}

