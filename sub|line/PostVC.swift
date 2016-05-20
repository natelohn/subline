//
//  PostVC.swift
//  subline
//
//  Created by Nate Lohn on 5/11/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postCreatorAtPostTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var newCommentTextField: UITextField!
    
    var db = DataBase()
    var username = ""
    var groupName = ""
    var subgroupName = ""
    var posts = [PFObject]()
    var postKey = ""
    var comments = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Post username = \(username)")
        print("Post group = \(groupName)")
        print("Post subgroup = \(subgroupName)")
        print("Post key = \(postKey)")
        let post = db.getPost(postKey)
        comments = db.getCommentsFromPost(post)
        postCreatorAtPostTimeLabel.text! = post["posterUsername"] as! String + " - " +  db.getDateStringFromPFObject(post)
        titleLabel.text! = post["title"] as! String
        descriptionLabel.text! = post["description"] as! String
        let nib = UINib(nibName: "CommentTableCellView", bundle: nil)
        commentsTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        commentsTableView.allowsSelection = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    @IBAction func sendButtonPushed(sender: UIButton) {
        let text = newCommentTextField.text!
        db.addComment(username, text: text, postKey: postKey)
        newCommentTextField.text! = ""
        comments = db.getComments(postKey)
        commentsTableView.reloadData()
    }
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let key = comment["key"] as! String
        let userVotedUp = db.userVotedUpComment(username, commentKey:key)
        let userVotedDown = db.userVotedDownComment(username, commentKey:key)
        let cell:CommentTableCell = self.commentsTableView.dequeueReusableCellWithIdentifier("cell") as! CommentTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.username = comment["username"] as! String
        cell.commentKey = key
        cell.userUpVoted = userVotedUp
        cell.userDownVoted = userVotedDown
        cell.userLabel.text = comment["username"] as? String
        cell.commentLabel.text = comment["text"] as? String
//        cell.scoreLabel.text = String(comment["score"])
        cell.timeLabel.text = db.getDateStringFromPFObject(comment)
        cell.userInteractionEnabled = true
        if userVotedUp {
//            cell.downVoteButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
//            cell.upVoteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }
        if userVotedDown {
//            cell.upVoteButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
//            cell.downVoteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }
        if cell.username == username {
            cell.commentLabel.textAlignment = NSTextAlignment.Right
        }
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 40 //height of the post table cell in the xib file
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newCommentTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if newCommentTextField.editing{
            let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            self.view.window?.frame.origin.y = -1 * keyboardFrame.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.view.window?.frame.origin.y += keyboardFrame.height
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSubgroupVC"{
            let DestinationViewController : SubgroupVC = segue.destinationViewController as! SubgroupVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
            DestinationViewController.subgroupName = subgroupName
            DestinationViewController.posts = posts
        }
        
    }
}
