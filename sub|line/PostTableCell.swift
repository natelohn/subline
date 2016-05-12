//
//  PostTableCellTableViewCell.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class PostTableCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var post = Post()
    var username = ""
    
    @IBAction func upVote(sender: UIButton) {
        if !post.votedUp(username) {
            print("\(username) upvoted")
            post.updateScore(1)
            scoreLabel.text = String(post.getScore())
            post.addVote(username, up: true)
            upButton.selected = true
            downButton.selected = false
        }
    }
    
    @IBAction func downVote(sender: UIButton) {
        if !post.votedDown(username) {
            print("\(username) downvoted")
            post.updateScore(-1)
            scoreLabel.text = String(post.getScore())
            post.addVote(username, up: false)
            upButton.selected = false
            downButton.selected = true
        }
    }
    

}
