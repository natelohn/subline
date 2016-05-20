//
//  CommentTableCell.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    let db = DataBase()
    var commentKey = ""
    var username = ""
    var userUpVoted = false
    var userDownVoted = false
    
    
    @IBAction func upvotePused(sender: UIButton) {
        if !userUpVoted {
            print("\(username) upvoted")
            let newScore = Int(scoreLabel.text!)! + 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addCommentVote(username, commentKey:commentKey, up:true)
            upVoteButton.selected = true
            downVoteButton.selected = false
            userDownVoted = false
            userUpVoted = true
        }
    }

    @IBAction func downvotePushed(sender: UIButton) {
        if !userDownVoted {
            print("\(username) downvoted")
            let newScore = Int(scoreLabel.text!)! - 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addCommentVote(username, commentKey:commentKey, up:false)
            upVoteButton.selected = false
            downVoteButton.selected = true
            userDownVoted = true
            userUpVoted = false
        }
    }
}
