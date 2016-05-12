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


    var comment = Comment()
    var username = ""
    
    @IBAction func upvotePused(sender: UIButton) {
        if !comment.votedUp(username) {
            print("\(username) upvoted")
            comment.updateScore(1)
            scoreLabel.text = String(comment.score)
            comment.addVote(username, up: true)
            upVoteButton.selected = true
            downVoteButton.selected = false
        }
    }

    @IBAction func downvotePushed(sender: UIButton) {
        if !comment.votedDown(username) {
            print("\(username) downvoted")
            comment.updateScore(-1)
            scoreLabel.text = String(comment.score)
            comment.addVote(username, up: false)
            upVoteButton.selected = false
            downVoteButton.selected = true
        }
    }
}
