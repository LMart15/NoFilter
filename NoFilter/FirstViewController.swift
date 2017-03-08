//
//  FirstViewController.swift
//  HomeFeature Tab
//
//  Created by Harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var postTable: UITableView!
    var uProfile = [UserProfile]()
    var uPosts = [UserPost]()
    var userPosts = UserPost()
    var refHandle: UInt!
    var ref: FIRDatabaseReference!
    var userProfile = UserProfile()
    
    @IBOutlet weak var userProfilePic: UIImageView!
    
    @IBOutlet weak var userTagLine: UITextView!
    @IBOutlet weak var userProfileName: UILabel!
    
    
    
    
    var names=["Haapi","gopi","new"]
    
    var images=["best","gh","unn"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        fetchUser()
        //fetchPosts()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let user=cell.viewWithTag(2) as! UILabel
        user.text=names[indexPath.row]
        let imghs=cell.viewWithTag(3) as! UIImageView
        imghs.image=UIImage(named: images[indexPath.row])
        return cell
    }
    /* public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
     print("postCount",uPosts.count)
     return uPosts.count
     }
     
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
     let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
     let user=cell.viewWithTag(2) as! UILabel
     let imghs=cell.viewWithTag(3) as! UIImageView
     userPosts = uPosts[indexPath.row]
     
     user.text = userPosts.author
     let imgurl = userPosts.pathToImage
     let url = NSURL(string: imgurl)
     let data = NSData(contentsOf: url! as URL) // this URL convert into Data
     if data != nil {  //Some time Data value will be nil so we need to validate such things
     imghs.image = UIImage(data: data! as Data)
     }
     
     return cell
     }*/
    
    func fetchUser(){
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        print("usersID",userID!)
        let uref = FIRDatabase.database().reference().child("users").child(userID!)
        
        uref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                //print( "usersnapshot",snapshot.children.allObjects)
                self.userProfile.key = snapshot.key
                self.userProfile.fullName = dictionary["fullName"] as! String
                self.userProfile.profileImage = dictionary["profileImage"] as! String
                print("fullName",self.userProfile.fullName)
                self.userProfileName.text = self.userProfile.fullName
                let url = NSURL(string: self.userProfile.profileImage)
                let data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    self.userProfilePic.image = UIImage(data: data! as Data)
                }
                
                
            }
            
            DispatchQueue.main.async {
            }
            
        } , withCancel: nil)
        
    }
    
    func fetchPosts(){
        let eref = ref.child("posts")
        var userPost = UserPost()
        eref.observe(.value, with: { (snaps) in
            if let dict = snaps.value as? [String : AnyObject]
            {
                print("dictvalue",dict.values,"count",dict.count)
                print( "snapshot",snaps.children.allObjects,"count",snaps.childrenCount)
                //userPost.author = dict["author"] as! String
                //userPost.pathToImage = dict["pathToImage"] as! String
                
            }
            
            self.uPosts.append(userPost)
            
            DispatchQueue.main.async {
                self.postTable.reloadData()
            }
            
        } , withCancel: nil)
        
    }
}
