//
//  SubGroupVC.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class SubGroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var postTextfield: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    var subgroup = Subgroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PostTableCellView", bundle: nil)
        postTableView.registerNib(nib, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subgroup.getAllPosts().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:PostTableCell = self.postTableView.dequeueReusableCellWithIdentifier("cell") as! PostTableCell
        let post = subgroup.getAllPosts()[indexPath.row]
        cell.userLabel.text = post.getUser()
        cell.postLabel.text = post.getText()
        cell.dateLabel.text = post.getDate()
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250 //height from xib file
    }
    
    @IBAction func postButtonPushed(sender: UIButton) {
        let userText = userTextfield.text!
        let postText = postTextfield.text!
        let date = NSDate()
        
        let post = Post()
        post.setUser(userText)
        post.setText(postText)
        post.setDate(date)
        print(post.getDate())
        subgroup.addPost(post)
        
        postTableView.reloadData()
    }
    

}
