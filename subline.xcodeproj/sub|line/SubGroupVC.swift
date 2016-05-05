//
//  SubGroupVC.swift
//  sub|line
//
//  Created by Nate Lohn on 4/28/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit

class SubGroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var postTextfield: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    var subgroup = Subgroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PostTableCellView", bundle: nil)
        postTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubGroupVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubGroupVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        self.userTextfield.delegate = self
        self.postTextfield.delegate = self
    }
    
    //keyboard view logic
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //table view logic
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
