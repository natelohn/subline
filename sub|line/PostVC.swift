//
//  PostVC.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var postCreatorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var newCommentTextField: UITextField!
    
    var username = ""
    var group = Group()
    var subgroup = Subgroup()
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Post username =\(username)")
        print("Post group =\(group.name)")
        print("Post subgroup =\(subgroup.name)")
        print("Post post =\(post.title)")
        postCreatorLabel.text! = post.creator
        titleLabel.text! = post.title
        descriptionLabel.text! = post.descript
        let nib = UINib(nibName: "CommentTableCellView", bundle: nil)
        commentsTableView.registerNib(nib, forCellReuseIdentifier: "cell")
    }
    
    
    
    @IBAction func sendButtonPushed(sender: UIButton) {
        let newComment = Comment()
        let comment = newCommentTextField.text!
        newComment.createComment(username, comment:comment)
        post.addComment(newComment)
        commentsTableView.reloadData()
    }
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let comment = post.comments[indexPath.row]
        let cell:CommentTableCell = self.commentsTableView.dequeueReusableCellWithIdentifier("cell") as! CommentTableCell
        cell.username = username
        cell.userLabel.text = comment.commentor
        cell.commentLabel.text = comment.comment
        cell.scoreLabel.text = String(comment.score)
        cell.timeLabel.text = comment.timeString
        if comment.votedUp(username){
            cell.upVoteButton.selected = true
        }
        if post.votedDown(username){
            cell.downVoteButton.selected = true
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 100 //height of the post table cell in the xib file
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSubgroupVC"{
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.subgroup = subgroup
            
        }
        
    }
}
