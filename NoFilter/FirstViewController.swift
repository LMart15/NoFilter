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
    //@IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var postTable: UITableView!
    var uProfile = [UserProfile]()
    
    var uPostsList = [UserPost]()
    
    var userCellPosts = UserPost()
    var refHandle: UInt!
    var ref: FIRDatabaseReference!
    var userProfile = UserProfile()
    
    var posts=Post()          //fetch array info from post class which fetch posts from database server
    var numPosts=[Post]()
    
    @IBOutlet weak var userProfilePic: UIImageView!
   
    @IBOutlet weak var userTagLine: UITextView!
    @IBOutlet weak var userProfileName: UILabel!
   
    
   
    
    var names=["Haapi","gopi","new"]
    
    var images=["best","gh","unn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
    //  fetchPostedData()
        fetchUser()
        fetchPosts()

        
        // Do any additional setup after loading the view, typically from a nib.
    }

   func fetchPostedData()
   {
    ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
    
        let users=snapshot.value as! [String:AnyObject]
        
        for(_,value) in users{
            
            if let uid=value["uid"] as? String
            {
                if uid==FIRAuth.auth()?.currentUser?.uid{
                    
                    self.ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: {(snap)in
                        
                        let postSnap = snap.value as! [String: AnyObject]
                        for(_,post) in postSnap{
                            
                            if let userid=value["uid"] as? String {
                                if(uid==userid)
                                {
                                    let posst=self.posts
                                    if let author = post["displayName"] as? String, let likes=post["likes"] as? Int,let pathToImage=post["pathToImage"] as? String, let postId=post["postId"] as? String{
                                        posst.author = author
                                        posst.likes = likes
                                        posst.pathImage=pathToImage
                                        posst.postId=postId
                                        posst.userId=userid
                                        
                                        self.numPosts.append(posst)
                                    }
                                    self.postTable.reloadData()
                                }
                            }
                        }
                        
                    })
                    
                }
            }
            
        }
    
    })
    ref.removeAllObservers()
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print("postCount",uPosts.count)
        return uPostsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let user=cell.viewWithTag(2) as! UILabel
        let imghs=cell.viewWithTag(3) as! UIImageView
        userCellPosts = uPostsList[indexPath.row]
        print("postrow",userCellPosts)
        user.text = userCellPosts.author
        let imgurl = userCellPosts.pathToImage
        let url = NSURL(string: imgurl)
        let data = NSData(contentsOf: url! as URL) // this URL convert into Data
        if data != nil {  //Some time Data value will be nil so we need to validate such things
        imghs.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    func fetchUser(){
       
        let userID = FIRAuth.auth()?.currentUser?.uid
        //print("usersID",userID!)
        let uref = FIRDatabase.database().reference().child("users").child(userID!)
        
        uref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                //print( "usersnapshot",snapshot.children.allObjects)
                self.userProfile.key = snapshot.key
                self.userProfile.fullName = dictionary["fullName"] as! String
                self.userProfile.profileImage = dictionary["profileImage"] as! String
                //print("fullName",self.userProfile.fullName)
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
        let eref = FIRDatabase.database().reference().child("posts")
        var userPost = UserPost()
        
        eref.observe(.childAdded, with: { (snaps) in
            if let dictn = snaps.value as? [String : AnyObject]
            {
                let userID = FIRAuth.auth()?.currentUser?.uid
                if(userID == dictn["uId"] as? String){
                //print("postdictvalue",dict.values,"count",dict.count)
                print( "snapKey",snaps.key, "hello")
                userPost.author = dictn["displayName"] as! String
                userPost.likes = String(describing: dictn["likes"]) 
                userPost.pathToImage = dictn["pathToImage"] as! String
                userPost.postId = dictn["postId"] as! String
                userPost.uId = dictn["uId"] as! String
                userPost.key = snaps.key
                userPost.timestamp = dictn["timestamp"] as! String
                self.uPostsList.append(userPost)
                }
            }
            
            DispatchQueue.main.async {
                self.postTable.reloadData()
            }
            
        } , withCancel: nil)
        
    }
}

