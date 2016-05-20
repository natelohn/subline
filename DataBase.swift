//
//  DataBase.swift
//  subline
//
//  Created by Nate Lohn on 5/4/16.
//  Copyright © 2016 Nate Lohn. All rights reserved.
//

import Foundation
import Parse


class DataBase {
    
    
    //sign up
    func getAllUsernames() -> [String] {
        var allUsernames = [String]()
        let query = PFQuery(className: "User")
        let allUsers = try! query.findObjects() as [PFObject]
        for user in allUsers{
            allUsernames.append(user["username"] as! (String))
        }
        return allUsernames
    }
    
    
    func addUser(username:String, password:String){
        let newUser = PFObject(className: "User")
        newUser["username"] = username
        newUser["password"] = password
        newUser["groupnames"] = [String]()
        try! newUser.save()
    }
    
    //login 
    func getAllUsers() -> [PFObject]{
        let query = PFQuery(className: "User")
        let allUsers = try! query.findObjects() as [PFObject]
        return allUsers
    }
    
    
    func userHasGroupWithThisName(username:String, groupname:String) ->Bool {
        let groupnames = getAllUsersGroupNames(username)
        if groupnames.contains(groupname){
            return true
        } else {
            return false
        }
    }
    
    func groupNameExists(groupname:String) ->Bool {
        let allGroupnames = getAllGroupNames()
        if allGroupnames.contains(groupname){
            return true
        } else {
            return false
        }
    }
    
    func getAllGroupNames() -> [String]{
        var allGroupNames = [String]()
        let query = PFQuery(className: "Group")
        query.selectKeys(["name"])
        let allGroups = try! query.findObjects()
        for group in allGroups {
            allGroupNames.append(group["name"] as! String)
        }
        print("all group names::: \(allGroupNames)")
        return allGroupNames
    }
    
    //create group
    func addGroup(name:String, memberUsernames:[String]){
        let newGroup = PFObject(className: "Group")
        newGroup["name"] = name
        newGroup["memberUsernames"] = memberUsernames
        newGroup["subgroupNames"] = [String]()
        for username in memberUsernames{
            self.addGroupNameToUser(username, groupName: name)
        }
        try! newGroup.save()
    }
    
    func addGroupNameToUser(username:String, groupName:String){
        let user = getUser(username)
        var userGroupNames = getAllUsersGroupNames(username)
        userGroupNames.append(groupName)
        user["groupnames"] = userGroupNames
        user.saveInBackground()
    }
    
    func getGroupName(groupID:String) -> String{
        let query = PFQuery(className: "Group")
        let group = try! query.getObjectWithId(groupID)
        let name = group["name"] as! String
        return name
    }
    
    func getAllOtherUsernames(myUsername:String) -> [String] {
        let query = PFQuery(className: "User")
        var allUsernames = [String]()
        let allUsers = try! query.findObjects() as [PFObject]
        for user in allUsers{
            let username = user["username"] as! (String)
            if username != myUsername {
                allUsernames.append(user["username"] as! (String))
            }
        }
        return allUsernames
    }
    
    
    func getUser(username:String) -> PFObject{
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: username)
        let user = try! query.getFirstObject() as PFObject
        return user
    }
    
    func getAllUsersGroupNames(username:String) -> [String]{
        let user = getUser(username)
        if let groupnames = user["groupnames"] as? [String] {
            return groupnames
        } else {
            return [String]()
        }
    }
    
    func getAllSubgroupNamesInGroup(groupName:String) -> [String]{
        let group = getGroup(groupName)
        if let subgroupNames = group["subgroupNames"] as? [String]{
            return subgroupNames
        } else {
            return [String]()
        }
    }
    
    //create subgroup
    func addSubgroup(name:String, description:String, groupName:String){
        addSubgroupToGroup(groupName, subgroupName: name)
        let newSubgroup = PFObject(className: "Subgroup")
        newSubgroup["name"] = name
        newSubgroup["description"] = description
        newSubgroup["postKeys"] = [String]()
        newSubgroup.saveInBackground()
    }
    
    func addSubgroupToGroup(groupName:String, subgroupName:String){
        let group = getGroup(groupName)
        var subgroupNames = group["subgroupNames"] as! [String]
        subgroupNames.append(subgroupName)
        group["subgroupNames"] = subgroupNames
        group.saveInBackground()
    }
    
    func subgroupNameExists(subgroupName:String) ->Bool {
        let allSubgroupNames = getAllSubgroupNames()
        if allSubgroupNames.contains(subgroupName){
            return true
        } else {
            return false
        }
    }
    
    func getAllSubgroupNames() -> [String]{
        var allSubgroupNames = [String]()
        let query = PFQuery(className: "Subgroup")
        query.selectKeys(["name"])
        let allSubgroups = try! query.findObjects()
        for subgroup in allSubgroups {
           allSubgroupNames.append(subgroup["name"] as! String)
        }
        print("all subgroup names::: \(allSubgroupNames)")
        return allSubgroupNames
    }
    
    
    func getGroup(groupName:String) -> PFObject{
        let query = PFQuery(className: "Group")
        query.whereKey("name", equalTo: groupName)
        let group = try! query.getFirstObject()
        return group
    }
    
    
    func getUsersSubgroupsInGroup(username:String, groupID:String) -> [String:String] {
        let user = getUser(username)
        let allSubgroups = user["subgroups"] as! [String:[String:String]]
        if let subgroupsInGroup = allSubgroups[groupID] as [String:String]? {
            return subgroupsInGroup
        } else {
            return [String:String]()
        }
    }
    
    func getSubgroup(subgroupName:String) -> PFObject{
        print("subgroup to find = \(subgroupName)")
        let query = PFQuery(className: "Subgroup")
        query.whereKey("name", equalTo: subgroupName)
        let subgroup = try! query.getFirstObject()
        return subgroup
    }
    
    
    func postKeyExists(postKey:String) -> Bool {
        let allPostKeys = getAllPostKeys()
        if allPostKeys.contains(postKey){
            return true
        } else {
            return false
        }
    }
    
    func getAllPostKeys() -> [String]{
        var allPostKeys = [String]()
        let query = PFQuery(className: "Post")
        query.selectKeys(["key"])
        let allPosts = try! query.findObjects()
        for post in allPosts {
            allPostKeys.append(post["key"] as! String)
        }
        print("all post keys::: \(allPostKeys)")
        return allPostKeys
        
    }
    
    //create post
    func addPost(poster:String, title: String, description:String, key:String, subgroupName:String){
        addPostToSubgroup(key, subgroupName: subgroupName)
        let newPost = PFObject(className: "Post")
        newPost["title"] = title
        newPost["description"] = description
        newPost["posterUsername"] = poster
        newPost["key"] = key
        newPost["commentKeys"] = [String]()
        newPost["upVoteUsernames"] = [String]()
        newPost["downVoteUsernames"] = [String]()
        newPost["score"] = 0
        newPost.saveInBackground()
    }
    
    func addPostToSubgroup(key:String, subgroupName:String){
        print("adding post to \(subgroupName)")
        let subgroup = getSubgroup(subgroupName)
        var postKeys =  subgroup["postKeys"] as! [String]
        postKeys.append(key)
        subgroup["postKeys"] = postKeys
        subgroup.saveInBackground()
    }
    
    
    func getAllPostsInSubgroup(subgroupName:String) -> [PFObject]{
        var posts = [PFObject]()
        let subgroup = getSubgroup(subgroupName)
        let postKeys = subgroup["postKeys"] as! [String]
        for key in postKeys{
            let post = getPost(key)
            posts.append(post)
        }
        return posts
    }
    
    func getPost(key:String) -> PFObject{
        let query = PFQuery(className: "Post")
        query.whereKey("key", equalTo: key)
        let post = try! query.getFirstObject()
        return post
    }
    
    
    
    //post cell
    func userVotedUp(username:String, postKey:String) ->Bool {
        let post = getPost(postKey)
        let userWhoUpVoted = post["upVoteUsernames"] as! [String]
        if userWhoUpVoted.contains(username){
            return true
        } else {
            return false
        }
    }
    
    func userVotedDown(username:String, postKey:String) ->Bool {
        let post = getPost(postKey)
        let userWhoDownVoted = post["downVoteUsernames"] as! [String]
        if userWhoDownVoted.contains(username){
            return true
        } else {
            return false
        }
    }
    
    func addVote(username:String, postKey:String, up:Bool){
        let post = getPost(postKey)
        if up {
            var downVoteUsernames = post["downVoteUsernames"] as! [String]
            if downVoteUsernames .contains(username){
                for (index, name) in downVoteUsernames.enumerate(){
                    if name == username{
                        downVoteUsernames.removeAtIndex(index)
                    }
                }
            }
            post["downVoteUsernames"] = downVoteUsernames
            var upvoteUsernames = post["upVoteUsernames"] as! [String]
            upvoteUsernames.append(username)
            post["upVoteUsernames"] = upvoteUsernames
            var postScore = post["score"] as! Int
            postScore = postScore + 1
            post["score"] = postScore
        } else {
            var upvoteUsernames = post["upVoteUsernames"] as! [String]
            if upvoteUsernames.contains(username){
                for (index, name) in upvoteUsernames.enumerate(){
                    if name == username{
                        upvoteUsernames.removeAtIndex(index)
                    }
                }
            }
            post["upVoteUsernames"] = upvoteUsernames
            
            var downVoteUsernames = post["downVoteUsernames"] as! [String]
            downVoteUsernames.append(username)
            post["downVoteUsernames"] =  downVoteUsernames
            var postScore = post["score"] as! Int
            postScore = postScore - 1
            post["score"] = postScore
        }
        post.saveInBackground()
    }
    
    
    //create comment
    func addComment(username:String, text:String, postKey:String){
        let r = rand()
        let key = username + text + String(r)
        addCommentToPost(key, postKey: postKey)
        let newComment = PFObject(className: "Comment")
        newComment["username"] = username
        newComment["text"] = text
        newComment["upVoteUsernames"] = [String]()
        newComment["downVoteUsernames"] = [String]()
        newComment["score"] = 0
        newComment["key"] = key
        newComment.saveInBackground()
    }
    
    func addCommentToPost(key:String, postKey:String){
        let post = getPost(postKey)
        var commentKeys =  post["commentKeys"] as! [String]
        commentKeys.append(key)
        post["commentKeys"] = commentKeys
        post.saveInBackground()
        
    }
    
    func getCommentsFromPost(post:PFObject) -> [PFObject]{
        var comments = [PFObject]()
        let commentKeys = post["commentKeys"] as! [String]
        for key in commentKeys {
            let comment = getComment(key)
            comments.append(comment)
        }
        return comments
    }
    
    func getComments(postKey:String) -> [PFObject]{
        let post = getPost(postKey)
        var comments = [PFObject]()
        let commentKeys = post["commentKeys"] as! [String]
        for key in commentKeys {
            let comment = getComment(key)
            comments.append(comment)
        }
        return comments
    }
    
    func getComment(key:String) -> PFObject{
        print("getComment's key = \(key)")
        let query = PFQuery(className: "Comment")
        query.whereKey("key", equalTo: key)
        let comment = try! query.getFirstObject()
        return comment
    }
    
    func userVotedUpComment(username:String, commentKey:String) -> Bool {
        print("userVotedUp Called")
        let comment = getComment(commentKey)
        print("userVotedUpCalled got comment")
        let userWhoUpVoted = comment["upVoteUsernames"] as! [String]
        if userWhoUpVoted.contains(username){
            return true
        } else {
            return false
        }
    }
    
    func userVotedDownComment(username:String, commentKey:String) -> Bool{
        let comment = getComment(commentKey)
        let userWhoDownVoted = comment["downVoteUsernames"] as! [String]
        if userWhoDownVoted.contains(username){
            return true
        } else {
            return false
        }
    }
    
    func addCommentVote(username:String, commentKey:String, up:Bool){
        print("addCommentVote called")
        let comment = getComment(commentKey)
        if up {
            print("addCommentVote was UP")
            var downVoteUsernames = comment["downVoteUsernames"] as! [String]
            if downVoteUsernames .contains(username){
                print("\(username) changed vote to UP")
                for (index, name) in downVoteUsernames.enumerate(){
                    if name == username{
                        downVoteUsernames.removeAtIndex(index)
                    }
                }
                comment["downVoteUsernames"] = downVoteUsernames
            }
            var upvoteUsernames = comment["upVoteUsernames"] as! [String]
            upvoteUsernames.append(username)
            comment["upVoteUsernames"] = upvoteUsernames
            var postScore = comment["score"] as! Int
            postScore = postScore + 1
            comment["score"] = postScore
        } else {
            var upvoteUsernames = comment["upVoteUsernames"] as! [String]
            if upvoteUsernames.contains(username){
                for (index, name) in upvoteUsernames.enumerate(){
                    if name == username{
                        upvoteUsernames.removeAtIndex(index)
                    }
                }
                comment["upVoteUsernames"] = upvoteUsernames
            }
            var downVoteUsernames = comment["downVoteUsernames"] as! [String]
            downVoteUsernames.append(username)
            comment["downVoteUsernames"] =  downVoteUsernames
            var postScore = comment["score"] as! Int
            postScore = postScore - 1
            comment["score"] = postScore
        }
        comment.saveInBackground()
    }
    
    
    func getDateStringFromPFObject(object:PFObject) -> String{
        let date = object.createdAt
        let df = NSDateFormatter()
        df.dateFormat = "EEEE dd/MM @ hh:mm a"
        let timeString = df.stringFromDate(date!)
        return timeString
    }
    
    
    func addFeedback(username:String, text:String){
        let feedback = PFObject(className: "Feedback")
        feedback["user"] = username
        feedback["text"] = text
        feedback.saveInBackground()
    }
    
//    func getAllPostsFromSubgroup(subgroupName:String) -> [PFObject]{
//        let subgroup = getSubgroup(subgroupName)
//        for postID in subgroup["postIDs"] as! [String]{
//            
//        }
//    
//    }
    
//    func getPost(postID:String) -> PFObject{
//        
//    }
//    
    
    ///////////////////////////////////////////////////////
    
    
//    func getUser(username:String) -> PFObject{
//        
//    }
//    
//    func addGroupToUser(user:String, groupID:String){
//        
//    }
    
    
//    
//    func queryUsers(){
//        let query = PFQuery(className:"User")
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//                if let returnedObjects = objects {
//                    self.users = returnedObjects
//                    //delete DB
////                    for del in returnedObjects {
////                        del.deleteInBackground()
////                        print("deleted")
////                    }
//                }
//            }
//        }
//    }
//    
//    //will need to restart the app to get the most current users with this method
//    func getAllUsers(){
//        print("get em")
//        queryUsers()
//        while users.count == 0 {
//            queryUsers()
//            print("while")
//        }
//    }
    
    
//    func isUser(username:String) -> Bool {
//        for user in users {
//            if user.objectForKey("username") as! String == username {
//                return true
//            }
//        }
//        return false
//    }
    
//    func getUserFromDB(username:String) -> PFObject{
//        for user in users{
//            if user["username"] as! String == username {
//                return user
//            }
//        }
//        return PFObject()
//    }
    
//    func getAllOtherUsernames(username:String) ->[User]{
////        var users = [User]()
////        for user in users{
////            if user["username"] as! String != username {
////                let addUsername = user["username"] as! String
////                usernames.append(addUsername)
////            }
////        }
////        return usernames
//        
//    }
    
//    func saveUser(username:String, password:String){
//        let newUser = PFObject(className: "User")
//        newUser["username"] = username
//        newUser["password"] = password
//        newUser["groups"] = [Group]()
//        newUser.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError?) -> Void in
//            if (success) {
//                print("signed up!")
//            } else {
//                print("sign up failed")
//            }
//        }
//    }
    
//    func saveGroup(allNewMembers:Set<String>, newGroup:Group){
//        print("begin save group")
//        let query = PFQuery(className: "User")
//        query.whereKey("username", containedIn: Array(allNewMembers))
//        do {
//            let usersToAdd = try query.findObjects()
//            for user in usersToAdd {
//                print("adding \(user["username"])")
//                user.addUniqueObject(newGroup, forKey: "groups")
//                user.saveInBackground()
//            }
//        } catch {
//            print(error)
//        }
//        
//        
//    }
//    
//    func addUserToGroup(user:PFObject, group:Group){
//        user.addUniqueObject(group, forKey: "groups")
//        user.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError?) -> Void in
//            if (success) {
//                print("added user!")
//            } else {
//                print("add user failed")
//            }
//        }
//    }
    
//    
//    func getAllGroups(username:String) -> [Group]{
//        let user = getUserFromDB(username)
//        return user["groups"] as! [Group]
//    }
//    
//    

    
}
