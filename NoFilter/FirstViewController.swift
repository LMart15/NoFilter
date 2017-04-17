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
    
     var valueToPass:String!
       var obj=AudioRecorder()
    
    //likes
    @IBOutlet weak var likes: UILabel!
    
    @IBOutlet weak var postTable: UITableView!
    var uProfile = [UserProfile]()
    
    var uPostsList = [UserPost]()
    
    var userCellPosts = UserPost()
    var refHandle: UInt!
    var ref: FIRDatabaseReference!
    var userProfile = UserProfile()
    var userRef: FIRDatabaseReference!
    var posts=Post()          //fetch array info from post class which fetch posts from database server
    var numPosts=[Post]()
    var postt:String?
    @IBOutlet weak var userProfilePic: UIImageView!
   
    
    @IBOutlet weak var showStatus: UILabel!
    
    @IBOutlet weak var editStatusButton: UIButton!
    
    @IBOutlet weak var editStatusArea: UITextField!
       var editStatusFirstValue=false
    @IBOutlet weak var userProfileName: UILabel!
   
    
    var names=["Haapi","gopi","new"]
    
    var images=["best","gh","unn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference() //?????
        obj.pid="x"
    //  fetchPostedData()
        fetchUser()
        fetchPosts()
//
        //status things
        
         editStatusArea.isEnabled=false
         editStatusArea.isHidden=true
        
        //status
        
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
        let tB = cell.viewWithTag(8) as! UIButton
        let vB=cell.viewWithTag(7) as! UIButton

        
        //imghs.layer.clipsToBounds= YES;
        //imghs.layer.contentMode = UIViewContentModeScaleAspectFit;
        
        // Calling Segue functions to pass Post IDs
        vB.addTarget(self, action: #selector(FirstViewController.voiceBtnHandler(sender:)), for: UIControlEvents.touchUpInside)
        
        tB.addTarget(self, action: #selector(FirstViewController.textBtnHandler(sender:)), for: UIControlEvents.touchUpInside)
        
        
        userCellPosts = uPostsList[indexPath.row]
//        print("postrow",userCellPosts)
        
        user.text = userCellPosts.author
        let imgurl = userCellPosts.pathToImage
        let url = NSURL(string: imgurl)
        let data = NSData(contentsOf: url! as URL) // this URL convert into Data
        if data != nil {  //Some time Data value will be nil so we need to validate such things
        imghs.image = UIImage(data: data! as Data)
            cell.postId=self.uPostsList[indexPath.row].postId
            self.valueToPass=self.uPostsList[indexPath.row].postId
           
            print("show Post ID in First View Controller >>>>>>\(self.valueToPass)")
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
             if let statusTemp = dictionary["userStatus"] as! String!
             {
                if statusTemp != nil {
                    self.userProfile.status = statusTemp
//                    print(statusTemp)
                }
                }
                self.userProfileName.text = self.userProfile.fullName
                self.showStatus.text = self.userProfile.status
                let url = NSURL(string: self.userProfile.profileImage)
                let data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    self.userProfilePic.image = UIImage(data: data! as Data)
                    self.userProfilePic.layer.cornerRadius = self.userProfilePic.frame.width/2.0
                    self.userProfilePic.layer.masksToBounds = true
                }
                
            
            }
            
            else{
                //fetch latest post from permanent friend's profile
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
//                print( "snapKey",snaps.key, "hello")
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
    
    @IBAction func performEditStatus(_ sender: Any) {
        
    if(editStatusFirstValue==true)
    {
        let userStatusRef = self.ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
        let status=editStatusArea.text
        editStatusArea.isEnabled=false
        editStatusArea.isHidden=true
        showStatus.isEnabled=true
        showStatus.isHidden=false
        showStatus.text=status
        editStatusButton.setTitle("Edit", for: .normal)
        editStatusFirstValue=false
        
        userStatusRef.updateChildValues(["userStatus": status])
      
    }
       else if(editStatusFirstValue==false)
        {
        editStatusFirstValue=true
           let status=showStatus.text
             showStatus.isEnabled=false
        showStatus.isHidden=true
        editStatusArea.isEnabled=true
        editStatusArea.isHidden=false
        editStatusArea.text=status
        editStatusButton.setTitle("Done", for: .normal)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "do" {
           
                let controller = segue.destination as! AudioRecorder
                controller.pid = self.valueToPass
                print("PID from Segue in FVC Do\(self.valueToPass)")
            
        }
        else if segue.identifier == "textSend" {
            
            let commentsController = segue.destination as! CommentsViewController
            commentsController.pid = self.valueToPass
            print("PID from Segue in FVC textSend \(self.valueToPass)")
            
        }
    }
    
    func voiceBtnHandler(sender:UIButton)
    {
         self.performSegue(withIdentifier: "do", sender:self)
    }
    
    func textBtnHandler(sender:UIButton)
    {
        self.performSegue(withIdentifier: "textSend", sender:self)
    }
   
    
    
}

