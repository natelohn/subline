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
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var lastCommentLabel: UILabel!

    
    
    private var post = Post()
    
    @IBAction func sendButtonPushed(sender: UIButton) {
        let comment = commentTextfield.text!
        lastCommentLabel.text = comment
        //need to store comments
    }
    
    
    @IBAction func upVote(sender: UIButton) {
        post.updateScore(1)
        scoreLabel.text = String(post.getScore())
        print("up!")
    }
    
    @IBAction func downVote(sender: UIButton) {
        post.updateScore(-1)
        scoreLabel.text = String(post.getScore())
        print("down!")
    }
    

}
