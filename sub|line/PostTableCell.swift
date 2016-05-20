//
//  PostTableCellTableViewCell.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class PostTableCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let db = DataBase()
    let brain = PostBrain()
    var postKey = ""
    var username = ""
    var userUpVoted = false
    var userDownVoted = false
    
    
    @IBAction func upVote(sender: UIButton) {
        if !userUpVoted {
            print("\(username) upvoted")
            let newScore = Int(scoreLabel.text!)! + 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addVote(username, postKey: postKey, up:true)
            upButton.selected = true
            downButton.selected = false
            userDownVoted = false
            userUpVoted = true
        }
    }
    
    @IBAction func downVote(sender: UIButton) {
        if !userDownVoted {
            print("\(username) downvoted")
            let newScore = Int(scoreLabel.text!)! - 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addVote(username, postKey: postKey, up:false)
            upButton.selected = false
            downButton.selected = true
            userDownVoted = true
            userUpVoted = false
        }

    }
    

}
