//
//  SubGroupVC.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import Parse

class SubgroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    

    @IBOutlet weak var postTableView: UITableView!
    
    var db = DataBase()
    var username = ""
    var groupName = ""
    var subgroupName = ""
    var posts = [PFObject]()
    var selectedPostKey = ""
    
    
    var group = Group()
    var subgroup = Subgroup()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Subgroup's username = \(username)")
        print("Subgroup's group = \(groupName)")
        print("Subgroup's subgroup = \(subgroupName)")
        posts = db.getAllPostsInSubgroup(subgroupName)
        let nib = UINib(nibName: "PostTableCellView", bundle: nil)
        postTableView.registerNib(nib, forCellReuseIdentifier: "cell")
    }
    

    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let key = post["key"] as! String
        let userVotedUp = db.userVotedUp(username, postKey:key)
        let userVotedDown = db.userVotedDown(username, postKey:key)
        let cell:PostTableCell = self.postTableView.dequeueReusableCellWithIdentifier("cell") as! PostTableCell
        cell.username = username
        cell.postKey = key
        cell.userUpVoted = userVotedUp
        cell.userDownVoted = userVotedDown
        cell.userLabel!.text = post["posterUsername"] as? String
        cell.dateLabel.text! = db.getDateStringFromPFObject(post)
        cell.titleLabel.text! = post["title"] as! String
        cell.descriptionLabel.text! = post["description"] as! String
        cell.scoreLabel.text! = String(post["score"])
        
        if userVotedUp {
            cell.upButton.selected = true
        }
        if userVotedDown {
            cell.downButton.selected = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPostKey = posts[indexPath.row]["key"] as! String
        self.performSegueWithIdentifier("toPostVC", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 168 //height of the post table cell in the xib file
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAllSubgroupsVC" {
            let DestinationViewController : AllSubgroupsVC = segue.destinationViewController as! AllSubgroupsVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName

        }
        if segue.identifier == "toCreatePostVC" {
            let DestinationViewController : CreatePostVC = segue.destinationViewController as!CreatePostVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
            DestinationViewController.subgroupName = subgroupName
            
        }
        if segue.identifier == "toPostVC" {
            let DestinationViewController : PostVC = segue.destinationViewController as! PostVC
            DestinationViewController.username = username
            DestinationViewController.groupName = groupName
            DestinationViewController.subgroupName = subgroupName
            DestinationViewController.posts = posts
            DestinationViewController.postKey = selectedPostKey
            
        }
        
    }

}
