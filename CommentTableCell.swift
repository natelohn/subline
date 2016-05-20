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
        print("comment up pushed")
        if !userUpVoted {
            print("\(username) upvoted")
            let newScore = Int(scoreLabel.text!)! + 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addCommentVote(username, commentKey:commentKey, up:true)
            upVoteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            downVoteButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            userDownVoted = false
            userUpVoted = true
        }
    }

    @IBAction func downvotePushed(sender: UIButton) {
        print("comment down pushed")
        if !userDownVoted {
            print("\(username) downvoted")
            let newScore = Int(scoreLabel.text!)! - 1
            scoreLabel.text = String(newScore) //just subtract from label ammount
            db.addCommentVote(username, commentKey:commentKey, up:false)
            upVoteButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            downVoteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            userDownVoted = true
            userUpVoted = false
        }
    }
}
