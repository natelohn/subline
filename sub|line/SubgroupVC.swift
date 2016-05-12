//
//  SubGroupVC.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class SubgroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var postTextfield: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    var username = ""
    var group = Group()
    var subgroup = Subgroup()
    var selectedPost = Post()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Subgroup's username = \(username)")
        print("Subgroup's group = \(group.name)")
        print("Subgroup's subgroup = \(subgroup.name)")
        let nib = UINib(nibName: "PostTableCellView", bundle: nil)
        postTableView.registerNib(nib, forCellReuseIdentifier: "cell")
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubgroupVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubgroupVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
//    //keyboard view logic
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subgroup.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = subgroup.posts[indexPath.row]
        let cell:PostTableCell = self.postTableView.dequeueReusableCellWithIdentifier("cell") as! PostTableCell
        cell.post = post
        cell.username = username
        cell.userLabel!.text = post.creator
        cell.dateLabel.text! = post.time
        cell.titleLabel.text! = post.title
        cell.descriptionLabel.text! = post.descript
        cell.scoreLabel.text! = String(post.getScore())
        if post.votedUp(username){
            cell.upButton.selected = true
        }
        if post.votedDown(username){
            cell.downButton.selected = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost = subgroup.posts[indexPath.row]
        self.performSegueWithIdentifier("toPostVC", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 168 //height of the post table cell in the xib file
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllSubgroupsVC"{
            let DestinationViewController : AllSubgroupsVC = segue.destinationViewController as! AllSubgroupsVC
            DestinationViewController.username = username
            DestinationViewController.group = group

        }
        if segue.identifier == "toCreatePostVC"{
            let DestinationViewController : CreatePostVC = segue.destinationViewController as!CreatePostVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.subgroup = subgroup
            
        }
        if segue.identifier == "toPostVC"{
            let DestinationViewController : PostVC = segue.destinationViewController as! PostVC
            DestinationViewController.username = username
            DestinationViewController.group = group
            DestinationViewController.subgroup = subgroup
            DestinationViewController.post = selectedPost
            
        }
        
    }

}
