//
//  AllGroupsVC.swift
//  subline
//
//  Created by Nate Lohn on 5/5/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import UIKit
import RealmSwift

class AllGroupsVC: UIViewController {
    
    @IBOutlet weak var groupTableView: UITableView!
    
    let db = DataBase()
    var username = ""
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("user: \(username)")
        user = db.getUserFromDB(username)
        groupTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        user.printAllGroups()
    }
    
    
    
    //table view logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel!.text = user.groups[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        self.performSegueWithIdentifier("toCreateGroupVC", sender: self) //not sure if self should be something else
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50 //height of the post table cell in the xib file
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreateGroupVC"{
            let DestinationViewController : CreateGroupVC = segue.destinationViewController as! CreateGroupVC
            DestinationViewController.username = username
        }
    }
    
    
    

}
