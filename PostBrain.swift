//
//  PostBrain.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation

class PostBrain {
    
    func createPost(subgroup:Subgroup, creator:String, title:String, description:String){
        let post = Post()
        let date = NSDate()
        post.createPost(creator, title: title, description: description, date: date)
        subgroup.addPost(post)
    }
    
    
}
